$ErrorActionPreference = 'Continue'
$base = 'http://127.0.0.1:8787'
function Call($method, $path, $body, $sess) {
  $p = @{ Uri = "$base$path"; Method = $method; UseBasicParsing = $true; ErrorAction = 'Stop' }
  if ($sess) { $p.WebSession = $sess }
  if ($body -ne $null) { $p.Body = ($body | ConvertTo-Json -Depth 8); $p.ContentType = 'application/json' }
  try { $r = Invoke-WebRequest @p; return @{ code = [int]$r.StatusCode; body = ($r.Content | ConvertFrom-Json -ErrorAction SilentlyContinue); raw = $r.Content } }
  catch { $resp = $_.Exception.Response; $txt = ''; if ($resp) { $txt = (New-Object IO.StreamReader($resp.GetResponseStream())).ReadToEnd() }; return @{ code = [int]$resp.StatusCode; body = ($txt | ConvertFrom-Json -ErrorAction SilentlyContinue); raw = $txt } }
}
function Show($name, $r, $expect) { $ok = if ($r.code -eq $expect) { 'PASS' } else { 'FAIL' }; "{0} {1} -> {2} (expected {3}) {4}" -f $ok, $name, $r.code, $expect, ($r.raw.Substring(0, [Math]::Min(110, $r.raw.Length)) -replace "`n", ' ') }

$r = Call GET '/staff-console' $null; Show 'admin login page (anon)' $r 200; "   contains admin bundle? " + ($r.raw -match 'admin-app/assets')
$r = Call GET '/admin-app/index.html' $null; Show 'admin bundle (anon) hidden' $r 404
$r = Call GET '/admin-app/assets/x.js' $null; Show 'admin asset (anon) hidden' $r 404
$r = Call GET '/api/admin/users' $null; Show 'admin API (anon)' $r 401
$r = Call GET '/api/courses' $null; Show 'learner API (anon)' $r 401
$r = Call GET '/api/admin/status' $null; Show 'setup status' $r 200
$r = Call POST '/api/admin/setup' @{ token = 'wrong'; email = 'a@x.com'; password = 'Sup3rSecretPass!'; name = 'Boss' } $null; Show 'setup wrong token' $r 403
$r = Call POST '/api/admin/setup' @{ token = 'local-dev-setup-token-123456'; email = 'boss@fundsindia.test'; password = 'weak'; name = 'Boss' } $null; Show 'setup weak password' $r 400
$r = Call POST '/api/admin/setup' @{ token = 'local-dev-setup-token-123456'; email = 'boss@fundsindia.test'; password = 'Sup3rSecretPass!'; name = 'Boss' } $null; Show 'setup OK' $r 200
$r = Call POST '/api/admin/setup' @{ token = 'local-dev-setup-token-123456'; email = 'x@fundsindia.test'; password = 'Sup3rSecretPass!'; name = 'X' } $null; Show 'setup twice blocked' $r 403

$adm = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$r = Call POST '/api/admin/login' @{ email = 'boss@fundsindia.test'; password = 'nope' } $adm; Show 'admin wrong pw' $r 401
$r = Call POST '/api/admin/login' @{ email = 'boss@fundsindia.test'; password = 'Sup3rSecretPass!' } $adm; Show 'admin login' $r 200
$r = Call GET '/admin-app/index.html' $null $adm; Show 'admin bundle (signed in)' $r 200
$r = Call GET '/staff-console' $null $adm; Show 'admin console (signed in)' $r 200; "   serves SPA? " + ($r.raw -match 'admin-app/assets')
$r = Call GET '/api/admin/stats' $null $adm; Show 'admin stats' $r 200
$r = Call GET '/api/courses' $null $adm; Show 'admin cookie on learner API (must fail)' $r 401

$r = Call POST '/api/admin/users' @{ name = 'Asha Rao'; email = 'asha@fundsindia.test'; empId = 'E1'; role = 'learner'; team = 'MF Silver' } $adm; Show 'create learner' $r 200
$tmp = $r.body.created[0].password
$ln = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$r = Call POST '/api/auth/login' @{ email = 'asha@fundsindia.test'; password = 'bad'; team = 'MF Silver' } $ln; Show 'learner wrong pw' $r 401
$r = Call POST '/api/auth/login' @{ email = 'asha@fundsindia.test'; password = $tmp; team = 'MF Silver' } $ln; Show 'learner login (temp pw)' $r 200; "   mustChange=" + $r.body.mustChange
$r = Call POST '/api/auth/password' @{ current = $tmp; next = 'Learner#Pass2026' } $ln; Show 'learner change pw' $r 200
$r = Call GET '/api/admin/stats' $null $ln; Show 'learner on admin API (must fail)' $r 401
$r = Call GET '/api/courses' $null $ln; Show 'courses' $r 200; "   courses=" + $r.body.courses.Count
$r = Call GET '/api/courses/nism-5a' $null $ln; Show 'course detail' $r 200; "   lessons=" + $r.body.lessons.Count + " quizzes=" + $r.body.quizzes.Count + " playlists=" + $r.body.course.playlists.Count
$lid = $r.body.lessons[0].id; $qid = ($r.body.quizzes | Where-Object { $_.is_exam })[0].id
$r = Call GET "/api/lessons/$lid" $null $ln; Show 'lesson' $r 200; "   body len=" + $r.body.lesson.body.Length
$r = Call POST "/api/lessons/$lid/complete" @{ done = $true } $ln; Show 'complete lesson' $r 200
$r = Call POST "/api/quizzes/$qid/start" @{} $ln; Show 'start exam' $r 200; "   qs=" + $r.body.questions.Count + " leaks answer? " + ($r.raw -match '"answer"')
$sid = $r.body.sessionId; $ans = @{}; foreach ($q in $r.body.questions) { $ans[$q.id] = 0 }
$r = Call POST "/api/quizzes/$qid/submit" @{ sessionId = $sid; answers = $ans } $ln; Show 'submit exam' $r 200; "   pct=" + $r.body.result.pct + " passed=" + $r.body.result.passed
$r = Call POST "/api/quizzes/$qid/submit" @{ sessionId = $sid; answers = $ans } $ln; Show 'resubmit blocked' $r 409
$r = Call GET '/api/dashboard' $null $ln; Show 'dashboard' $r 200
$r = Call GET '/api/search?q=nav' $null $ln; Show 'search' $r 200
$r = Call GET '/api/feeds' $null $ln; Show 'live feeds' $r 200; "   items=" + $r.body.items.Count

# brute force lockout
$t = New-Object Microsoft.PowerShell.Commands.WebRequestSession
1..6 | ForEach-Object { $r = Call POST '/api/auth/login' @{ email = 'victim@fundsindia.test'; password = "bad$_"; team = 'MF Silver' } $t }
Show 'lockout after repeated failures' $r 429

# CSRF-ish: cross-origin write
try { $x = Invoke-WebRequest -Uri "$base/api/auth/logout" -Method POST -Headers @{ Origin = 'https://evil.example' } -ContentType 'application/json' -Body '{}' -UseBasicParsing -ErrorAction Stop; "FAIL cross-origin allowed" } catch { "PASS cross-origin write blocked -> " + [int]$_.Exception.Response.StatusCode }
$h = (Invoke-WebRequest "$base/" -UseBasicParsing).Headers; "CSP: " + $h['Content-Security-Policy'].Substring(0, 80)
