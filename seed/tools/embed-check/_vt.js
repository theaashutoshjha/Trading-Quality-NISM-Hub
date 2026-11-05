
window.onYouTubeIframeAPIReady=()=>{const ids=window.IDS.slice();let active=0;window.DONE=0;
const run=()=>{while(active<8&&ids.length){const id=ids.shift();active++;const d=document.createElement('div');d.style.cssText='width:200px;height:112px';document.getElementById('host').appendChild(d);let fin=false;
const finish=(r)=>{if(fin)return;fin=true;window.RES[id]=r;window.DONE++;try{p.destroy()}catch(e){}d.remove();active--;run();};
const p=new YT.Player(d,{host:'https://www.youtube-nocookie.com',videoId:id,width:200,height:112,playerVars:{controls:0,disablekb:1,fs:0,rel:0,modestbranding:1,playsinline:1,origin:location.origin},events:{onReady:()=>{setTimeout(()=>finish('ok'),1200)},onError:(e)=>finish('err'+e.data)}});
setTimeout(()=>finish('timeout'),15000);}};run();};
const s=document.createElement('script');s.src='https://www.youtube.com/iframe_api';document.head.appendChild(s);