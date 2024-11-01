/**
 * 
 */

console.log("연결 확인");

document.getElementById("trigger").addEventListener("click",()=> {
    document.getElementById('file').click();
});

// 실행파일에 대한 정규표현식 작성 / 파일 최대 사이즈 20MB
// \ 로 시작, $로 끝
const regExp = new RegExp("\.(exe|jar|msi|dll|sh|bat)$");
const maxSize = 1024*1024*20;       // 파일 용량

function fileValidation(fileName, fileSize) {
    if(regExp.test(fileName)) {                 // .test => boolean true | false return;
        return 0;
    } else if(fileSize > maxSize) {
        return 0;
    } else {
        return 1;
    }         
}

document.addEventListener('change',(e)=> {
    console.log(e.target);
    if(e.target.id == 'file') {                 // 파일창에 변화가 생겼다면(파일 업로드되면)
        // type="File" element 에 저장된 file 정보를 가져오는 property files 
        const fileObj = document.getElementById('file').files;
        console.log(fileObj);

        // 한번 disabled 되면 혼자 false가 될 수 없음. 버튼을 원상복구
        document.getElementById('regBtn').disabled = false;

        // 내가 등록한 파일정보를 파일 목록으로 기록
        // 등록한 파일이 fileValidation 에 맞지 않으면 register 버튼을 비활성화
        // 파일 목록에 업로드 불가능이라고 시뻘겋게 출력.
        let div = document.getElementById("fileZone");
        div.innerHTML = "";         // 새로 추가되는 목록이 있다면 삭제 후 처리

       // 여러개의 첨부파일이 모두 검증을 통과해야만 register 버튼을 활성화
       // isOk = 1 * 1 => 모두 1(누적 곱)
       let isOk = 1;
       let ul = `<ul class="list-group list-group-flush">`;
       
       // 개별 파일에 대한 검증 / 결과 표시
       for(let file of fileObj) {
            // 개별 파일에 대한 검증 결과 리턴 변수
            let validResult = fileValidation(file.name, file.size);
            isOk *= validResult;
            ul += `<li class="list-group-item">`;
            ul += `<div class="ms-2 me-auto">`;
            ul += `${validResult ? '<div class="fw-bold text-success-emphasis">업로드 가능</div>':'<div class="fw-bold text-danger-emphasis">업로드 불가능</div>'}`;
            ul += `${file.name}</div>`;
            ul += `<span class="badge text-bg-${validResult ? 'success':'danger'} rounded-pill">${file.size} byte</span>`;
            ul += `</li>`;
       }
       ul += `</ul>`;
       div.innerHTML = ul;

       if(isOk == 0) {
        // 하나라도 검증을 통과하지 못한 파일이 있다면 버튼을 비활성화
        document.getElementById('regBtn').disabled = true;
       }
    }
});