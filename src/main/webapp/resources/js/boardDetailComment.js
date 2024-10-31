/**
 * 
 */
 
 console.log("boardDetailComment.js in"); 
 
 
 console.log("vscode 연동 성공");
 console.log("끼얏호우~!~!~!~!~!");

 document.getElementById("cmtAdd").addEventListener('click', ()=>{
    const cmtText = document.getElementById("cmtText");
    const cmtWriter = document.getElementById("cmtWriter");

    if(cmtText.value == null || cmtText.value =='') {
        alert('댓글을 입력해주세요.');
        cmtText.focus();
        return false;
    }
    let cmtData={
        bno: bnoVal,
        writer: cmtWriter.innerText,
        content: cmtText.value
    }
    console.log(cmtData);
    postCommentToServer(cmtData).then(result => {
        if(result == '1') {
            alert('댓글 등록 성공');
            cmtText.value = "";
            // 댓글 뿌리기
            spreadCommentList(bnoVal);
        }
    })
 } );

 async function postCommentToServer(cmtData) {
    try {
        const url = "/comment/post";
        const config = {
            method: "post",
            headers: {
                'content-type':'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        console.log(resp);
        const result = await resp.text();   // isOk
        
        return result;
    } catch (error) {
        console.log(error);
    }
 };

async function getCommentListFromServer(bno, page) {
    try {
        const resp = await fetch("/comment/"+bno+"/"+page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 수정 삭제
document.addEventListener('click', (e)=> {
    console.log(e.target);
    // 내가 클릭한 버트의 객체를 모달 창으로 전달
    if(e.target.classList.contains('mod')) {
        // 내가 클릭한 버튼의 li 가져오기
        // closest : 가장 가까운(나를 포함한) 태그 (부모태그)
        let li = e.target.closest('li');
        // nextSibling : 한 부모 안에서 다음 객체

        // <div class="fw-bold">Comment name</div>
	    //   Content
	    // </div>

        // 위 태그에서 nextSibling 처리하면 class="fw-bold" 인 태그 다음 text 값을 가져옴
        
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        console.log(cmtText);
        document.getElementById('cmtTextMod').value = cmtText.nodeValue;
        let cno = li.dataset.cno;
        let cmtWriter = li.querySelector('.fw-bold').innerText;
        console.log(cmtWriter);
        document.getElementById('cmtWriterMod').innerHTML = `${cno} / ${cmtWriter}`;
        // cmtModBtn => cno dataset으로 달아놓기
        document.getElementById('cmtModBtn').setAttribute("data-cno",cno);
    }

    if(e.target.id == 'cmtModBtn') {
        let cmtData = {
            cno:e.target.dataset.cno,
            content: document.getElementById('cmtTextMod').value
        }
        console.log(cmtData);
        updateCommentToServer(cmtData).then(result => {
            if(result === '1') {
                alert('댓글 등록 성공');
            } else {
                alert('실패');
            }
            // 모달창 닫기 : btn-close 라는 객체를 클릭해라.
            document.querySelector('.btn-close').click;
            cmtText.value = "";
            // 댓글 뿌리기
            spreadCommentList(bnoVal);
        })
    }
    if(e.target.classList.contains("del")) {
        // cno만 있으면 됨
        let li = e.target.closest('li');
        let cno = li.dataset.cno;
        removeCommentToServer(cno).then(result => {
            if(result === '1') {
                alert('댓글 등록 성공');
            } else {
                alert('실패');
            }
            spreadCommentList(bnoVal);
        })
    }
})

async function updateCommentToServer(cmtData) {
    try {
        const url = "/comment/modify";
        const config = {
            method: 'put',
            headers: {
                'content-Type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        // fetch() 내 , 가 아닌 . 으로 잘못 쓰면 기존 전체에서 불러온 url로 처리됨
        // 141 line fetch(url. config);  => url 다음 '.' 처리
        // 처리하면 홈페이지 network request url 이 페이지 구성 시 불러왔던 board가 상위디렉터리 처리됨
        // 오류 request : http://localhost:8089/board/undefined
        // 정상 처리 request : http://localhost:8089/comment/modify
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

async function removeCommentToServer(cno) {
    try {
        const url = "/comment/"+cno;
        const config = {
            method: 'delete'
        }
        const resp = await fetch(url, config);
        // const resp = await fetch("/comment/"+cno, {method: 'delete'});
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// get은 생략 가능
 function spreadCommentList(bno, page=1) {
        getCommentListFromServer(bno, page).then(result => {
        // 댓글 뿌리기
        console.log(result);
        const ul = document.getElementById("cmtListArea");
        let li = "";
        if(result.length > 0) {
            ul.innerHTML=""; // 반복 전 기존 예시를 초기화.
            for(let cvo of result){
                li += `<li class="list-group-item" data-cno=${cvo.cno}>`;
                li += `<div class="ms-2 me-auto">`;
                li += `<div class="fw-bold">${cvo.writer}</div>`;
                li += `${cvo.content}`;
                li += `</div>`;
                li += `<span class="badge text-bg-primary rounded-pill">${cvo.regDate}</span>`;
                // 수정 삭제 버튼 추가
                li += `<button type="button" data-cno=${cvo.cno} class="btn btn-primary mod" data-bs-toggle="modal" data-bs-target="#myModal">수정</button>`
                li += `<button type="button" data-cno=${cvo.cno} class="btn btn-danger del">삭제</button>`;
                li += `</li>`;
            }
                ul.innerHTML = li;
        } else {
            ul.innerHTML = `<div>Comment List None.</div>`;
        }
    });

 };

