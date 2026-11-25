# Smoke tests for paths, resume points, feeds, admin video import. Run against `npm run dev` (admin + learner demo users must exist).
$b = 'http://127.0.0.1:8787'; $d = $env:TEMP
function J($o) { $f = Join-Path $d ([guid]::NewGuid().ToString() + '.json'); ($o | ConvertTo-Json -Depth 6 -Compress) | Set-Content $f -Encoding ascii; $f }
function Post($url, $body, $jar) { $f = J $body; $r = curl.exe -s -b $jar -c $jar -H "Content-Type: application/json" -d "@$f" "$b$url"; Remove-Item $f; $r | ConvertFrom-Json }
function Get($url, $jar) { curl.exe -s -b $jar "$b$url" | ConvertFrom-Json }
$A = Join-Path $d 'sA.txt'; $L = Join-Path $d 'sL.txt'; Remove-Item $A, $L -ErrorAction SilentlyContinue
$null = Post '/api/admin/login' @{ email = 'boss@fundsindia.test'; password = 'Sup3rSecretPass!' } $A
$null = Post '/api/auth/login' @{ email = 'asha@fundsindia.test'; password = 'Learner#Demo2026'; team = 'MF Silver' } $L
$p = Get '/api/paths' $L; "paths: " + $p.paths.Count + " | first: " + $p.paths[0].title + " (" + $p.paths[0].total + " steps)"
$pd = Get '/api/paths/path-investing-zero' $L; "path detail items: " + $pd.items.Count
$lid = $pd.items[0].id
$r = Post "/api/lessons/$lid/position" @{ seconds = 20; duration = 100 } $L; "position saved: " + $r.ok + " completed=" + $r.completed
$ld = Get "/api/lessons/${lid}?path=path-investing-zero" $L; "resume seconds: " + $ld.resume + " | next: " + $ld.next.title
$r = Post "/api/lessons/$lid/position" @{ seconds = 95; duration = 100 } $L; "auto-complete at 95%: " + $r.completed
$dash = Get '/api/dashboard' $L; "dashboard streak=" + $dash.stats.streak + " lessons=" + $dash.stats.lessons + " activePaths=" + $dash.paths.active.Count
$f = Get '/api/feeds' $L; "feeds: " + $f.items.Count + " items from " + (($f.items | Select-Object -ExpandProperty source -Unique) -join ', ')
# admin: import a playlist into a temporary course, then delete it
$c = Post '/api/admin/courses' @{ code = 'TMP TEST'; title = 'Temp import test'; category = 'general' } $A; "created temp course: " + $c.id
$imp = Post "/api/admin/courses/$($c.id)/import-playlist" @{ url = 'https://www.youtube.com/playlist?list=PLHm1pyF7GOrSXcPgU9RAsaiTLEG7yXZ76'; module = 'Objection handling'; channel = 'Dr. Sanjay Tolani' } $A; "playlist import: added=" + $imp.added + " error=" + $imp.error
$one = Post "/api/admin/courses/$($c.id)/import-video" @{ url = 'https://www.youtube.com/watch?v=QmCKI5RHTGU' } $A; "single video import: " + $one.title + $one.error
$bad = Post "/api/admin/courses/$($c.id)/import-video" @{ url = 'https://www.youtube.com/watch?v=aaaaaaaaaaa' } $A; "bad video rejected: " + $bad.error
curl.exe -s -b $A -X DELETE -H "Content-Type: application/json" -d "{}" "$b/api/admin/courses/$($c.id)" | Out-Null
$ur = Get '/api/admin/users' $A; $asha = $ur.users | Where-Object { $_.email -eq 'asha@fundsindia.test' }; $pr = Get "/api/admin/users/$($asha.id)/progress" $A; "admin sees Asha progress: courses=" + $pr.courses.Count
"learner on admin path-api blocked: " + (curl.exe -s -o NUL -w "%{http_code}" -b $L "$b/api/admin/paths")
