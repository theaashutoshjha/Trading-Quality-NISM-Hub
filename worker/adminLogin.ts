// Standalone admin sign-in / first-run setup page. Contains no admin code or data.
export function adminLoginPage(nonce: string, adminPath: string) {
  return `<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow"><title>Staff sign-in</title>
<link rel="icon" href="/logo.png">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
:root{--bg:#e6ebf3;--tx:#161b26;--mut:#667189;--pri:#1d6ff2;--err:#d23b3b;--d:#b9c3d6;--l:#fff;--brand:linear-gradient(135deg,#10b86c,#1d6ff2)}
@media (prefers-color-scheme:dark){:root{--bg:#1d2230;--tx:#e8edf8;--mut:#93a0bb;--pri:#4f8dff;--err:#ff7b7b;--d:#141824;--l:#262d3f}}
*{box-sizing:border-box}body{margin:0;min-height:100vh;display:grid;place-items:center;background:var(--bg);color:var(--tx);font:15px/1.5 'Plus Jakarta Sans',system-ui,Segoe UI,sans-serif;padding:16px}
.card{width:100%;max-width:420px;background:var(--bg);border-radius:28px;padding:34px;box-shadow:9px 9px 20px var(--d),-9px -9px 20px var(--l)}
.bar{height:5px;width:64px;border-radius:99px;background:var(--brand);margin:14px 0}
img.logo{height:42px}h1{font-size:22px;margin:0 0 4px;font-weight:800}p.sub{color:var(--mut);margin:0 0 18px;font-size:13px}
label{display:block;font-size:11px;color:var(--mut);margin:16px 0 7px;text-transform:uppercase;letter-spacing:.08em;font-weight:800}
input{width:100%;padding:13px 16px;border-radius:14px;border:0;background:var(--bg);color:var(--tx);font:inherit;box-shadow:inset 5px 5px 10px var(--d),inset -5px -5px 10px var(--l)}
input:focus{outline:2px solid var(--pri);outline-offset:2px}
button{width:100%;margin-top:22px;padding:14px;border:0;border-radius:14px;background:var(--brand);color:#fff;font:inherit;font-weight:800;cursor:pointer;box-shadow:5px 5px 12px var(--d),-5px -5px 12px var(--l)}
button:active{box-shadow:inset 3px 3px 8px #0003}button:disabled{opacity:.6;cursor:wait}.err{color:var(--err);font-size:13px;min-height:18px;margin-top:12px}
.hide{display:none}.tag{display:inline-block;font-size:11px;font-weight:800;letter-spacing:.12em;text-transform:uppercase;color:var(--mut);margin-left:10px}
</style></head><body>
<form class="card" id="f" autocomplete="off">
  <img class="logo" src="/logo.png" alt="FundsIndia"><span class="tag">Admin portal</span><div class="bar"></div>
  <h1 id="t">Staff sign-in</h1><p class="sub" id="s">Restricted area. Authorised personnel only. All activity is logged.</p>
  <div id="setupTok" class="hide"><label>Setup token</label><input id="token" type="password" autocomplete="off"></div>
  <div id="nameRow" class="hide"><label>Full name</label><input id="name" autocomplete="off"></div>
  <label>E-mail</label><input id="email" type="email" required autocomplete="username">
  <label>Password</label><input id="pw" type="password" required autocomplete="current-password">
  <div id="codeRow" class="hide"><label>Authenticator code</label><input id="code" inputmode="numeric" maxlength="6" autocomplete="one-time-code"></div>
  <div class="err" id="err" role="alert"></div>
  <button id="go">Sign in</button>
</form>
<script nonce="${nonce}">
const $=id=>document.getElementById(id);let setup=false;
fetch('/api/admin/status').then(r=>r.json()).then(s=>{if(s.needsSetup){setup=true;$('t').textContent='Create first administrator';$('s').textContent='One-time setup. You need the SETUP_TOKEN secret configured on the server (min 12-character password).';
$('setupTok').classList.remove('hide');$('nameRow').classList.remove('hide');$('go').textContent='Create administrator';$('pw').autocomplete='new-password';}});
$('f').addEventListener('submit',async e=>{e.preventDefault();$('err').textContent='';$('go').disabled=true;
try{
 if(setup){const r=await fetch('/api/admin/setup',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({token:$('token').value,name:$('name').value,email:$('email').value,password:$('pw').value})});
  const d=await r.json();if(!r.ok)throw new Error(d.error);setup=false;location.reload();return;}
 const r=await fetch('/api/admin/login',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({email:$('email').value,password:$('pw').value,code:$('code').value})});
 const d=await r.json();if(!r.ok)throw new Error(d.error||'Sign-in failed');
 if(d.needCode){$('codeRow').classList.remove('hide');$('code').focus();$('err').textContent='Enter the 6-digit code from your authenticator app.';return;}
 location.href='${adminPath}';
}catch(x){$('err').textContent=x.message}finally{$('go').disabled=false}});
</script></body></html>`;
}
