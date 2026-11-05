# Admin-only account management + data persistence across logout/login. Needs `npm run dev` and the 3 admin accounts.
param([string]$AdminPassword = $env:ADMIN_PASSWORD)
$b = 'http://127.0.0.1:8787'; $d = $env:TEMP; $fail = 0
function J($o) { $f = Join-Path $d ([guid]::NewGuid().ToString() + '.json'); ($o | ConvertTo-Json -Depth 6 -Compress) | Set-Content $f -Encoding ascii; $f }
function Req($m, $url, $body, $jar) { $a = @('-s', '-w', "`n%{http_code}", '-X', $m, '-b', $jar, '-c', $jar, '-H', 'Content-Type: application/json'); if ($null -ne $body) { $f = J $body; $a += @('-d', "@$f") } else { $a += @('-d', '{}') }; $o = (& curl.exe @a "$b$url") -join "`n"; if ($f) { Remove-Item $f }; $i = $o.LastIndexOf("`n"); $code = [int]$o.Substring($i + 1); $txt = $o.Substring(0, $i); [pscustomobject]@{ code = $code; body = ($txt | ConvertFrom-Json -ErrorAction SilentlyContinue) } }
function Check($name, $ok, $extra = '') { if ($ok) { "PASS  $name $extra" } else { $script:fail++; "FAIL  $name $extra" } }
function Jar($n) { $p = Join-Path $d "jar_$n.txt"; Remove-Item $p -ErrorAction SilentlyContinue; $p }

# 1. all three admins can sign in with the shared password
foreach ($e in 'rajesh.chakravarthi@fundsindia.com', 'ashutosh.kumar@fundsindia.com', 'ashwini.prabhu@fundsindia.com') {
  $j = Jar ($e.Split('@')[0]); $r = Req POST '/api/admin/login' @{ email = $e; password = $AdminPassword } $j
  Check "admin login $e" ($r.code -eq 200 -and $r.body.user.role -eq 'admin')
}
$A = Jar 'ashwini'; $null = Req POST '/api/admin/login' @{ email = 'ashwini.prabhu@fundsindia.com'; password = $AdminPassword } $A

# 2. no self-registration
Check 'self-signup endpoint is gone' ((Req POST '/api/auth/signup' @{ email = 'x@fundsindia.com'; name = 'X'; password = 'Aa1aaaaaaaaa' } (Jar 'anon')).code -eq 404)

# 3. admin creates a learner
$u = Req POST '/api/admin/users' @{ name = 'Persist Test'; email = 'persist.test@fundsindia.com'; role = 'learner' } $A
Check 'admin creates learner' ($u.code -eq 200 -and $u.body.created.Count -eq 1)
$tmp = $u.body.created[0].password; $L = Jar 'learner'
$null = Req POST '/api/auth/login' @{ email = 'persist.test@fundsindia.com'; password = $tmp } $L
$null = Req POST '/api/auth/password' @{ current = $tmp; next = 'Persist#Test2026' } $L

# 4. learner cannot create/delete accounts; trainer cannot either
Check 'learner cannot create users' ((Req POST '/api/admin/users' @{ name = 'Evil'; email = 'evil@fundsindia.com' } $L).code -eq 401)
Check 'learner cannot list users' ((Req GET '/api/admin/users' $null $L).code -eq 401)
$t = Req POST '/api/admin/users' @{ name = 'Trainer T'; email = 'trainer.t@fundsindia.com'; role = 'trainer' } $A
$TR = Jar 'trainer'; $null = Req POST '/api/admin/login' @{ email = 'trainer.t@fundsindia.com'; password = $t.body.created[0].password } $TR
Check 'trainer can sign in to admin portal' ((Req GET '/api/admin/me' $null $TR).code -eq 200)
Check 'trainer cannot create users' ((Req POST '/api/admin/users' @{ name = 'Evil'; email = 'evil2@fundsindia.com' } $TR).code -eq 403)
$uid2 = ((Req GET '/api/admin/users' $null $A).body.users | Where-Object { $_.email -eq 'persist.test@fundsindia.com' }).id
Check 'trainer cannot delete users' ((Req DELETE "/api/admin/users/$uid2" $null $TR).code -eq 403)

# 5. learner builds up data
$c = (Req GET '/api/courses/fi-academy' $null $L).body; $lesson = ($c.lessons | Select-Object -First 1).id; $lesson2 = ($c.lessons | Select-Object -Skip 1 -First 1).id
$null = Req POST "/api/lessons/$lesson/complete" @{ done = $true } $L
$null = Req POST "/api/lessons/$lesson2/position" @{ seconds = 37; duration = 120 } $L
$qz = (Req GET '/api/courses/nism-5a' $null $L).body.quizzes[0]; $s = (Req POST "/api/quizzes/$($qz.id)/start" @{} $L).body
$ans = @{}; foreach ($x in $s.questions) { $ans[$x.id] = 0 }; $null = Req POST "/api/quizzes/$($qz.id)/submit" @{ sessionId = $s.sessionId; answers = $ans } $L
$before = (Req GET '/api/dashboard' $null $L).body

# 6. sign out, sign back in, data is the same
$null = Req POST '/api/auth/logout' @{} $L
Check 'signed out (session dead)' ((Req GET '/api/auth/me' $null $L).code -eq 401)
$L2 = Jar 'learner2'; $r = Req POST '/api/auth/login' @{ email = 'persist.test@fundsindia.com'; password = 'Persist#Test2026' } $L2
Check 'sign back in' ($r.code -eq 200 -and -not $r.body.mustChange)
$after = (Req GET '/api/dashboard' $null $L2).body
Check 'lessons completed unchanged' ($after.stats.lessons -eq $before.stats.lessons -and $after.stats.lessons -ge 1) "($($after.stats.lessons))"
Check 'quiz attempts unchanged' ($after.stats.attempts -eq $before.stats.attempts -and $after.stats.attempts -ge 1) "($($after.stats.attempts))"
Check 'resume point unchanged' ((Req GET "/api/lessons/$lesson2" $null $L2).body.resume -eq 37)
Check 'attempt history unchanged' ((Req GET '/api/attempts' $null $L2).body.attempts.Count -ge 1)

# 7. another learner never sees this data
$oth = Req POST '/api/admin/users' @{ name = 'Other Person'; email = 'other.person@fundsindia.com' } $A; $OJ = Jar 'other'
$null = Req POST '/api/auth/login' @{ email = 'other.person@fundsindia.com'; password = $oth.body.created[0].password } $OJ
Check 'other learner has own empty dashboard' ((Req GET '/api/dashboard' $null $OJ).body.stats.lessons -eq 0)

# 8. admin password reset / suspend keep the data; delete requires admin and removes it
$null = Req POST "/api/admin/users/$uid2/reset" @{} $A
$null = Req PUT "/api/admin/users/$uid2" @{ name = 'Persist Test'; status = 'suspended'; role = 'learner' } $A
Check 'suspended learner cannot sign in' ((Req POST '/api/auth/login' @{ email = 'persist.test@fundsindia.com'; password = 'Persist#Test2026' } (Jar 'x')).code -in 401, 403)
$null = Req PUT "/api/admin/users/$uid2" @{ name = 'Persist Test'; status = 'active'; role = 'learner' } $A
$prog = (Req GET "/api/admin/users/$uid2/progress" $null $A).body
Check 'data still there after reset + suspend + reactivate' ($prog.courses.Count -ge 1 -and $prog.attempts.Count -ge 1)

# cleanup
foreach ($e in 'persist.test@fundsindia.com', 'trainer.t@fundsindia.com', 'other.person@fundsindia.com') {
  $id = ((Req GET '/api/admin/users' $null $A).body.users | Where-Object { $_.email -eq $e }).id
  $null = Req DELETE "/api/admin/users/$id" $null $A
}
Check 'admin can delete accounts (cleanup)' (-not ((Req GET '/api/admin/users' $null $A).body.users | Where-Object { $_.email -eq 'persist.test@fundsindia.com' }))
Get-ChildItem $d -Filter 'jar_*.txt' | Remove-Item -ErrorAction SilentlyContinue
"`n$fail failure(s)"


