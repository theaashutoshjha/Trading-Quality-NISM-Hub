// Standalone Head Portal sign-in page. Contains no portal bundle or data.
export function headLoginPage(nonce: string) {
  return `<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow"><title>Head Portal — Sign in</title>
<link rel="icon" href="/logo.png">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
:root{--bg:#e6ebf3;--tx:#161b26;--mut:#667189;--pri:#1d6ff2;--err:#d23b3b;--d:#b9c3d6;--l:#fff;--brand:linear-gradient(135deg,#10b86c,#1d6ff2)}
@media (prefers-color-scheme:dark){:root{--bg:#1d2230;--tx:#e8edf8;--mut:#93a0bb;--pri:#4f8dff;--err:#ff7b7b;--d:#141824;--l:#262d3f}}
*{box-sizing:border-box}body{margin:0;min-height:100vh;display:grid;place-items:center;background:var(--bg);color:var(--tx);font:15px/1.5 'Plus Jakarta Sans',system-ui,Segoe UI,sans-serif;padding:16px}
.card{width:100%;max-width:420px;background:var(--bg);border-radius:28px;padding:34px;box-shadow:9px 9px 20px var(--d),-9px -9px 20px var(--l)}
.bar{height:5px;width:64px;border-radius:99px;background:var(--brand);margin:14px 0}
img.logo{height:44px;border-radius:10px;background:#fff;padding:4px}h1{font-size:22px;margin:0 0 4px;font-weight:800}p.sub{color:var(--mut);margin:0 0 18px;font-size:13px}
label{display:block;font-size:11px;color:var(--mut);margin:16px 0 7px;text-transform:uppercase;letter-spacing:.08em;font-weight:800}
input{width:100%;padding:13px 16px;border-radius:14px;border:0;background:var(--bg);color:var(--tx);font:inherit;box-shadow:inset 5px 5px 10px var(--d),inset -5px -5px 10px var(--l)}
input:focus{outline:2px solid var(--pri);outline-offset:2px}
button{width:100%;margin-top:22px;padding:14px;border:0;border-radius:14px;background:var(--brand);color:#fff;font:inherit;font-weight:800;cursor:pointer;box-shadow:5px 5px 12px var(--d),-5px -5px 12px var(--l)}
button:active{box-shadow:inset 3px 3px 8px #0003}button:disabled{opacity:.6;cursor:wait}.err{color:var(--err);font-size:13px;min-height:18px;margin-top:12px}
.hide{display:none}.tag{display:inline-block;font-size:11px;font-weight:800;letter-spacing:.12em;text-transform:uppercase;color:var(--mut);margin-left:10px}
</style></head><body>
<form class="card" id="f" autocomplete="off">
  <img class="logo" src="/logo.png" alt="FundsIndia"><span class="tag">Head portal</span><div class="bar"></div>
  <h1>Team Head sign-in</h1><p class="sub">Manage teams, add team members, and review learning content.</p>
  <label>User ID or E-mail</label><input id="email" required autocomplete="username">
  <label>Password</label><input id="pw" type="password" required autocomplete="current-password">
  <div id="codeRow" class="hide"><label>Authenticator code</label><input id="code" inputmode="numeric" maxlength="6" autocomplete="one-time-code"></div>
  <div class="err" id="err" role="alert"></div>
  <button id="go">Sign in</button>
  <div style="margin-top:18px;text-align:center;font-size:11px;color:var(--mut)">Planned, designed, and developed by Rajesh Chakravarthi Rao</div>
</form>
<script nonce="${nonce}">
const $=id=>document.getElementById(id);
$('f').addEventListener('submit',async e=>{e.preventDefault();$('err').textContent='';$('go').disabled=true;
try{
 const r=await fetch('/api/head/login',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({email:$('email').value,password:$('pw').value,code:$('code').value})});
 const d=await r.json();if(!r.ok)throw new Error(d.error||'Sign-in failed');
 if(d.needCode){$('codeRow').classList.remove('hide');$('code').focus();$('err').textContent='Enter the 6-digit code from your authenticator app.';return;}
 location.href='/head';
}catch(x){$('err').textContent=x.message}finally{$('go').disabled=false}});
</script></body></html>`;
}
