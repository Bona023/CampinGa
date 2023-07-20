// main
$(function() {
	$('.newCampImgs').mouseenter(function() {
		$(this).children('.imgCover').animate({ top: 0 }, 1500)
	})
	$('.newCampImgs').mouseleave(function() {
		$(this).children('.imgCover').animate({ top: 300 }, 1500)
	})

	let num = 0;
	let dist;
	$('#btnL').click(function() {
		if (num == 0) return;
		num--;
		dist = -1 * 260 * num;
		$('.cards').animate({ left: dist }, 500)
	})
	$('#btnR').click(function() {
		if (num == 4) return;
		num++;
		dist = -1 * 260 * num;
		$('.cards').animate({ left: dist }, 500)
	})	
	
	$('.icons').mouseenter(function(){
		$(this).children('.iconImg1').animate({opacity:"0"}, 500)
		$(this).children('.iconImg2').animate({opacity:"1"}, 500)
	})
	$('.icons').mouseleave(function(){
		$(this).children('.iconImg1').animate({opacity:"1"}, 500)
		$(this).children('.iconImg2').animate({opacity:"0"}, 500)
	})
	
	$("#file").on('change',function(event){
	  	var fileName = $("#file").val();
	  	console.log("fileName"+fileName);
	  	$(".upload-name").val(fileName);
    
		var file = event.target.files[0];
		console.log("file"+file);

	    var reader = new FileReader(); 
	    reader.onload = function(e) {	
	        $("#previewImg").attr("src", e.target.result);
	    }
	
	    reader.readAsDataURL(file);
	});	
	
	// 메인 이미지 롤링
	var index=0;
	const order = new Array(1,2,3,4,3,2,1,0)
	setInterval(function(){
        $('#mainImg').animate({ left : order[index] * -1400 },4000);
            index++;
            if(index==8)index=0;
    }, 2000);
    
})


function selectimg(){
	var opt = "toolbar=no, scrollbars=no, location=no, menubar=no, resizable=no, width=810, height=600";
	window.open( 'multiImages' , 'selectimg',  opt);
}


// member JavaScript 
function login(){
	if(document.loginFrm.user.value=="1"){
		document.loginFrm.action = "login";
	    document.loginFrm.submit();
	} else {
		$('input[name=mid]').removeAttr("name").attr("name", "bid"); 
		
		document.loginFrm.action = "loginBS";
	    document.loginFrm.submit();
	}
}

function idcheck(type){
    if(document.joinForm.mid.value==""){
        alert("체크할 아이디를 입력해주세요");
        document.joinForm.mid.focus();
        return;
    }	
    var mid = document.joinForm.mid.value;
    var url = "idCheckForm?mid="+mid+"&type="+type;
	var opt = "toolbar=no, menubar=no, resizable=no, width=600, height=400, scrollbars=no";
	window.open(url, "idCheck", opt);
}

function Bsidcheck(){
    if(document.joinForm.bid.value==""){
        alert("체크할 아이디를 입력해주세요");
        document.joinForm.bid.focus();
        return;
    }   
    var id = document.joinForm.bid.value;
    var url = "BidCheckForm?bid="+ document.joinForm.bid.value;
   var opt = "toolbar=no, menubar=no, resizable=no, width=600, height=400, scrollbars=no";
   window.open(url, "idCheck", opt);
}

function idok(id){
    opener.document.joinForm.mid.value=id;
   	opener.document.joinForm.reid.value=id;
    self.close();
}

function bidok(bid){
    opener.document.joinForm.bid.value=bid;
      opener.document.joinForm.reid.value=bid;
    self.close();
}

function joinCheck(){
    if(document.joinForm.id.value==""){
        alert('아이디를 입력해주세요');
        document.joinForm.id.focus();
    } else if(document.joinForm.reid.value != document.joinForm.id.value){
        alert('아이디 중복확인을 하지 않았습니다.');
        document.joinForm.id.focus();
    }else if(document.joinForm.pwd.value==""){
        alert('비밀번호를 입력해주세요.');
        document.joinForm.pwd.focus();
    }else if(document.joinForm.pwd.value != document.joinForm.pwd_Check.value){
        alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
        document.joinForm.pwd.focus();
    }else if(document.joinForm.name.value==""){
        alert('이름를 입력해주세요');
        document.joinForm.name.focus();
    }else if(document.joinForm.phone.value==""){
        alert('전화번호를 입력해주세요');
        document.joinForm.phone.focus();
   }else if(document.joinForm.email.value==""){
        alert('이메일을 입력해주세요');
        document.joinForm.email.focus();
    }else {
        document.joinForm.action = "camp.do";
        document.joinForm.submit();
    }
}

function joinChoose(type){
    if(type==1){		
        document.getElementById("contract").innerHTML = "일반회원 가입약관";
        document.contractFrm.user.value = 1;
        return;
    } else if(type==2){
        document.getElementById("contract").innerHTML = "사업자회원 가입약관";
        document.contractFrm.user.value = 2;
        return;
    }
    return;
}

function go_next(){	
	console.log(document.contractFrm.user.value);
	if(document.contractFrm.user.value==""){
		alert("가입유형을 선택해 주세요")
		return;
	}
    if(document.contractFrm.okon[1].checked==true){
    alert("회원 약관에 동의 하셔야 회원으로 가입이 가능합니다.")
    }else{
    document.contractFrm.action = "joinForm";
    document.contractFrm.submit();
    }
}

function go_update(){
	document.updateInfo.action = "camp.do?command=updateUserInfo";
	document.updateInfo.submit();
}

function myResCancel( reseq ){
	let con = confirm("예약을 '취소'하시겠습니까?")
	if(con){
		location.href="cancelReservate?reseq="+reseq;
	}else{
		return;
	}
}

function myFavDel(cname, fseq){
	let con = confirm("'"+cname+"'을 즐겨찾기에서 삭제하시겠습니까?")
	if(con){
		location.href="deleteMyFavorites?fseq="+fseq;
	}else{
		return;
	}	
}




// camping JavaScript 
function reviewCheck(bseq){
    document.frm2.action="updateReview?bseq=" + bseq;
    document.frm2.submit();
}

function QnaCheck(bseq){
    document.frm1.action="updateQna?bseq=" + bseq;
    document.frm1.submit();
}

function qnawriteCheck(){
	if(document.frm.content.value==""){
		alert("내용을 작성해주세요")
		return;
	}else{
		document.frm.action="insertQna"
	}
}

function reviewwriteCheck(){
	if(document.form.content.value==""){
		alert("내용을 작성해주세요")
		return;
	}else{
		document.form.action="insertReview"
	}
}

const cat1_num = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
const cat1_name = new Array('','서울시','부산시','대구광역시','인천광역시','광주광역시','대전광역시','울산광역시','강원도','경기도','경상남도','경상북도','전라남도','전라북도','제주도','충청남도','충청북도');
	
const cat2_num = new Array();

function chDo(key){
    if(key == null) return;
    
	const cat2_name = new Array();
	
	cat2_name[1] = new Array('강남구','강동구','강북구','강서구','관악구','광진구','구로구','금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구','서초구','성동구','성북구','송파구','양천구','영등포구','용산구','은평구','종로구','중구','중랑구');
	cat2_name[2] = new Array('강서구','금정구','남구','동구','동래구','부산진구','북구','사상구','사하구','서구','수영구','연제구','영도구','중구','해운대구','기장군');
	cat2_name[3] = new Array('남구','달서구','동구','북구','서구','수성구','중구','달성군');
	cat2_name[4] = new Array('계양구','남구','남동구','동구','부평구','서구','연수구','중구','강화군','옹진군');
	cat2_name[5] = new Array('광산구','남구','동구','북구','서구');
	cat2_name[6] = new Array('대덕구','동구','서구','유성구','중구');
	cat2_name[7] = new Array('남구','동구','북구','중구','울주군');
	cat2_name[8] = new Array('강릉시','동해시','삼척시','속초시','원주시','춘천시','태백시','고성군','양구군','양양군','영월군','인제군','정선군','철원군','평창군','홍천군','화천군','횡성군');
	cat2_name[9] = new Array('고양시 덕양구','고양시 일산구','과천시','광명시','광주시','구리시','군포시','김포시','남양주시','동두천시','부천시 소사구','부천시 오정구','부천시 원미구','성남시 분당구','성남시 수정구','성남시 중원구','수원시 권선구','수원시 장안구','수원시 팔달구','시흥시','안산시 단원구','안산시 상록구','안성시','안양시 동안구','안양시 만안구','오산시','용인시','의왕시','의정부시','이천시','파주시','평택시','하남시','화성시','가평군','양주군','양평군','여주시','연천군','포천군');
	cat2_name[10] = new Array('거제시','김해시','마산시','밀양시','사천시','양산시','진주시','진해시','창원시','통영시','거창군','고성군','남해군','산청군','의령군','창녕군','하동군','함안군','함양군','합천군');
	cat2_name[11] = new Array('경산시','경주시','구미시','김천시','문경시','상주시','안동시','영주시','영천시','포항시 남구','포항시 북구','고령군','군위군','봉화군','성주군','영덕군','영양군','예천군','울릉군','울진군','의성군','청도군','청송군','칠곡군');
	cat2_name[12] = new Array('광양시','나주시','목포시','순천시','여수시','강진군','고흥군','곡성군','구례군','담양군','무안군','보성군','신안군','영광군','영암군','완도군','장성군','장흥군','진도군','함평군','해남군','화순군');
	cat2_name[13] = new Array('군산시','김제시','남원시','익산시','전주시 덕진구','전주시 완산구','정읍시','고창군','무주군','부안군','순창군','완주군','임실군','장수군','진안군');
	cat2_name[14] = new Array('서귀포시','제주시','남제주군','북제주군');
	cat2_name[15] = new Array('공주시','논산시','보령시','서산시','아산시','천안시','금산군','당진군','부여군','서천군','연기군','예산군','청양군','태안군','홍성군');
	cat2_name[16] = new Array('제천시','청주시 상당구','청주시 흥덕구','충주시','괴산군','단양군','보은군','영동군','옥천군','음성군','진천군','청원군');

  	let val = cat2_name[key];
	let target = document.getElementById("gungu");
	
	target.options.length = 0;
	
	for (x in val) {
		var opt = document.createElement("option");
		opt.value = val[x];
		opt.innerHTML = val[x];
		target.appendChild(opt);
	}
}

function mainSearch() {
	const sido = document.getElementById("sido").value;
	const gungu = document.getElementById("gungu").value;
	const cname = document.getElementById("inputText").value;
	// 검색 조건
	// 1. 주소 선택 o, 이름 검색 x
	// 2. 주소 선택 o, 이름 검색 o
	// 3. 주소 선택 x, 이름 검색 o --
	
	const ad1 = cat1_name[sido];
	location.href = "mainSearch?address1="+ad1+"&address2="+gungu+"&cname="+cname;
}

function searchCamp(){
	let key = document.getElementById("key").value;
	console.log(key)
    if(key==""){
        alert("검색어를 입력해주세요.")
        return;
    }else{
        location.href="CampNameSearch?key="+key
    }
}



// reserve
function go_reserve() {
	var input = confirm('예약하시겠습니까?');

	if (parseInt(document.reserve.people.value) > parseInt(document.reserve.max_people.value)) {
		alert('예약가능한 최대 인원 수 보다 많습니다.');
		document.reserve.people.focus();
		input = false;
	}

	if (input) {
		document.reserve.action = "reserveInsert";
		document.reserve.submit();

	}
}




// business
function busiJoinCheck() {
	if (document.joinForm.name.value == "") {
		alert('캠핑장 사업자님 이름를 입력해주세요');
		document.joinForm.name.focus();
	} else if (document.joinForm.id.value == "") {
		alert('아이디를 입력해주세요');
		document.joinForm.id.focus();
	} else if (document.joinForm.reid.value != document.joinForm.id.value) {
		alert('아이디 중복확인을 하지 않았습니다.');
		document.joinForm.id.focus();
	} else if (document.joinForm.cname.value == "") {
		alert('캠핑장 이름를 입력해주세요');
		document.joinForm.cname.focus();
	} else if (document.joinForm.pwd.value == "") {
		alert('비밀번호를 입력해주세요.');
		document.joinForm.pwd.focus();
	} else if (document.joinForm.pwd.value != document.joinForm.pwd_check.value) {
		alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
		document.joinForm.pwd.focus();
	} else if (document.joinForm.phone.value == "") {
		alert('전화번호를 입력해주세요');
		document.joinForm.phone.focus();
	} else if (document.joinForm.email.value == "") {
		alert('이메일을 입력해주세요');
		document.joinForm.email.focus();
	} else if (document.joinForm.caddress1.value == "0") {
		alert('도/시를 선택해주세요');
		document.joinForm.caddress1.focus();
	} else if (document.joinForm.caddress2.value == "0") {
		alert('시/군을 선택해주세요');
		document.joinForm.email.focus();
	} else if (document.joinForm.caddress3.value == "") {
		alert('상세주소까지 입력해주세요');
		document.joinForm.caddress3.focus();
	} else {
		document.joinForm.action = "camp.do?command=businessJoin";
		document.joinForm.submit();
	}
}


function go_update() {
	document.updateBusinessInfo.action = "camp.do?command=updateBusinessInfo";
	document.updateBusinessInfo.submit();
}

function reservate_cancel() {
	document.reservateInfo.action = "camp.do?command=businessmanCancelReservate";
	document.reservateInfo.submit();
}

function delete_favorites(fseq) {
	document.favorites.action = "camp.do?command=BusinessmanDeleteFavorites&fseq=" + fseq;
	document.favorites.submit();
}


function bsRepSave() {
	if(document.frm.reply.value==""){
		alert("답변 내용을 입력해주세요");
		document.frm.reply.focus();
		return;
	} else {
		document.frm.action = "businessmanQnaRepSave";
		document.frm.submit();
	}
}


function roomCheck() {
	if (document.frm.cname.value == "") {
		alert("이름 필수사항입니다");
		document.frm.cname.focus();
		return false;
	}
	if (document.frm.facilities.value == "") {
		alert("부대시설 필수사항입니다");
		document.frm.facilities.focus();
		return false;
	}
	if (document.frm.category.value == "") {
		alert("카테고리 필수사항입니다");
		document.frm.category.focus();
		return false;
	}
	if (document.frm.content.value == "") {
		alert("내용을 입력해주세요");
		document.frm.content.focus();
		return false;
	}
	if (document.frm.c_class.value == "") {
		alert("숙소종류 입력해주세요");
		document.frm.c_class.focus();
		return false;
	}
	return true;
}


// admin Login
function adminCheck() {
	if (document.frm.adminId.value == "") {
		alert("아이디를 입력하세요.");
		return false;
	} else if (document.frm.adminPwd.value == "") {
		alert("비밀번호를 입력하세요.");
		return false;
	} else {
		return true;
	}

}

// admin member

function go_search(action) {
	var key = document.frm.key.value;
	var url =  action + "?page=1&key=" + key;
	document.frm.action = url;
	document.frm.submit();
}




function go_total(action) {
	document.frm.key.value = "";
	document.frm.action = action + "?page=1";
	document.frm.submit();
}




function go_members_dormant() {
	var count = 0;
	if (document.frm.mid.length == undefined) {
		if (document.frm.mid.checked == true) count++;
	} else {
		for (var i = 0; i < document.frm.mid.length; i++) {
			if (document.frm.mid[i].checked == true) {
				count++;
			}
		}
	}
	if (count == 0) {
		alert("휴면정지시킬 회원을 선택하세요");
	}
	else {
		document.frm.action = "adminMemberDormant";
		document.frm.submit();
	}
}



// admin review
function go_review_delete() {
	var count = 0;
	if (document.frm.rseq.length == undefined) {
		if (document.frm.rseq.checked == true) count++;
	} else {
		for (var i = 0; i < document.frm.rseq.length; i++) {
			if (document.frm.rseq[i].checked == true) {
				count++;
			}
		}
	}
	if (count == 0) {
		alert("삭제할 리뷰를 선택하세요");
	}
	else {
		document.frm.action = "adminReviewDelete";
		document.frm.submit();
	}
}


// admin notice
function notiecDeleteChk(nseq) {
	if(confirm("이 공지사항을 삭제 하시겠습니까?")){
		location.href = "adminNoticeDelete?nseq="+nseq;
	} else {
		alert("삭제를 취소합니다.")
		return;
	}	
}

// admin campingList
function joinDormant(bseq, chkyn){
   alert("가입승인/휴면전환 합니다.");
   location.href="adminCampingJoinDormant?bseq="+bseq+"&chkyn="+chkyn;   
}

function businessDel(bseq){
	if(confirm("계정을 삭제하시겠습니까? 계정삭제시 복구되지 않습니다.")){
		location.href="adminCampingDelete?bseq="+bseq;
	}else{
		return;
	}
}


// banner 삭제
function orderChange( mbseq ){
	var selectTag = document.getElementById(mbseq);  	 
	var selectVal = selectTag.options[ selectTag.selectedIndex ].value;	
	location.href='orderChange?mbseq='+ mbseq +'&changeval='+selectVal;
}
function delBanner(mbseq){
	if(confirm("정말로 삭제하시겠습니까?")){
		location.href="adminBannerDelete?mbseq="+mbseq
	}else{
		return;
	}	
}


// ID, PW 찾기
$(function(){
	$('.findBtn').mouseenter(function() {
		$(this).children('span').css('color','#fff329')
	});
	$('.findBtn').mouseleave(function() {
		$(this).children('span').css('color','#44caef')
	});	
});