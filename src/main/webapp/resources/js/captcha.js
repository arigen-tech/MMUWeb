function captcha(){
    const fonts = ["cursive"];
   
    function gencaptcha()
    {
        let value = btoa(Math.random()*1000000000);
        value = value.substr(0,5 + Math.random()*5);
        captchaValue = value;
    }

    function setcaptcha()
    {
        let html = captchaValue.split("").map((char)=>{
            const rotate = -20 + Math.trunc(Math.random()*30);
            const font = Math.trunc(Math.random()*fonts.length);
            return`<span
            style="
            transform:rotate(${rotate}deg);
            font-family:${font[font]};
            "
           >${char} </span>`;
        }).join("");
        document.querySelector("#captcha .preview").innerHTML = html;
    }

    function initCaptcha()
    {
       // document.querySelector(".control-group #captcha .captcha_refersh").addEventListener("click",function(){
            gencaptcha();
            setcaptcha();
        //});

        gencaptcha();
        setcaptcha();
    }
    initCaptcha();

    
}