<%
' 페이지명: 관리자 공통 클래스 모음
' 작성자: 이용찬 - 2003/03/14
' 페이지설명
%>

<%
'-----------------------------------------------------------------------------------------------100
'동적배열 클래스
'-----------------------------------------------------------------------------------------------100
Class clsList
	dim size, maxsize, increment
	Dim arr()

	Private Sub Class_Initialize
		maxsize = 10
		increment = 10
		size = 0
		redim arr(maxsize)
	End Sub

    Function Count()
    	Count = size
    End Function

	Sub add(elem)
		if size > maxsize Then
			maxsize = maxsize + increment
			redim preserve arr(maxsize)		'old data must be preserved
		end if

		if isobject(elem) then
			set arr(size) = elem
		else
			arr(size) = elem
		end if
		size = size + 1
	end sub

	Sub remove(idx)
		Size = Size - 1
		Err.Raise 101, "User-Defined", "Remove Method is not yet implemented. just wait"
	End Sub

	function Item(idx)
		if isobject(arr(idx-1)) then
			set Item = arr(idx-1)
		Else
			Item = arr(idx-1)
		end if
	end function

	Private Sub Class_Terminate
		dim i
		for i = 0 to size - 1
			if isobject(arr(i)) then
				set arr(i) = nothing
			end if
		next
	End Sub
End Class


'-----------------------------------------------------------------------------------------------100
' 상품분류 클래스
'-----------------------------------------------------------------------------------------------100
Class clsGroup
	Public groupid
	Public upperid
	Public groupname
	Public groupimage
	Public description
	Public templateurl
	Public groupkind
	Public sortnum
	Public useyn

	Public subcnt
	Public level
	Public grouptype

	Private o_groups		'하위 상품분류 리스트
	Private o_products		'하위 상품 리스트

	Private Sub Class_Initialize
		Set o_groups = new clsList
		Set o_products = new clsList
	End Sub

	Public Property Get groups()
		Set groups = o_groups
	End Property

	Sub addGroup(o_group)
		o_groups.add o_group
		Set o_group = nothing
	End Sub

	Public Property Get products()
		Set products = o_products
	End Property

	Sub addProduct(o_prod)
		o_products.add o_prod
		Set o_prod = nothing
	end Sub

	Private Sub Class_Terminate
		set o_groups = nothing
		set o_products = nothing
	End Sub
End Class

'-----------------------------------------------------------------------------------------------100
' 상품 클래스
'-----------------------------------------------------------------------------------------------100
Class clsProduct
	Public prodid
	Public prodname
	Public prodimage
	Public prodcode
	Public prodspec
	Public keyword
	Public description
	Public detaildesc
	Public sellprice
	Public buyprice
	Public dcprice
	Public shipprice
	Public prodpoint
	Public vat
	Public unitname
	Public orderage
	Public sid
	Public mid
	Public did
	Public origin
	Public cardpolicy
	Public sellyn
	Public regdt
	Public useyn
	Public sortnum

	Public salecnt		'초기 판매수량
	Public soldcnt		'판매된 수량

	Public plantype
	Public plantype_name

	Function sellyn_name()
		Dim retstr
		Select Case sellyn
			Case "1" retstr = "판매중"
			Case "3" retstr = "일시품절"
			Case Else
				retstr = "비판매"
		End Select
		sellyn_name = retstr
	End Function
End Class

'-----------------------------------------------------------------------------------------------100
' 이벤트 클래스
'-----------------------------------------------------------------------------------------------100
Class clsEvent
	public eventid
	public eventname
	public eventtype
	public disptype
	public linktype
	public description
	public titleimage
	public linkimage1
	public linkimage2
	public avalstdt
	public avalendt
	public sortnum
	public useyn

	Private o_sections		'하위 섹션 리스트
	Private o_groups		'링크분류 리스트

	Private Sub Class_Initialize
		Set o_sections = new clsList
		Set o_groups = new clsList
	End Sub

	Public Property Get sections()
		Set sections = o_sections
	End Property

	Sub addSection(o_sect)
		o_sections.add o_sect
		Set o_sect = nothing
	End Sub

	Public Property Get groups()
		Set groups = o_groups
	End Property

	Sub addGroup(o_group)
		o_groups.add o_group
		Set o_group = nothing
	End Sub

	Private Sub Class_Terminate
		set o_sections = nothing
		set o_groups = nothing
	End Sub
End Class

'-----------------------------------------------------------------------------------------------100
' 이벤트섹션 클래스
'-----------------------------------------------------------------------------------------------100
Class clsEventSection
	public eventid
	public sectid
	public sectname
	public prodcnt
	public useyn
End Class

'-----------------------------------------------------------------------------------------------100
' 경매속성 클래스
'-----------------------------------------------------------------------------------------------100
Class clsAuction
	Public bidid		'경매번호
	Public prodid		'상품번호
	Public bidtype		'경매형태
	Public startamt		'입찰시작가
	Public maxamt		'입찰가능 최고가
	Public directamt	'바로구매가
	Public priceunit	'가격변동폭
	Public choicecnt	'낙찰자 수
	Public bidstatus	'경매상태
	Public avalstdt		'경매 시작일
	Public avalendt		'경매 종료일

	Public biddercnt		'입찰자 수
	Public lastbiddt	'최종입찰일시
	Public lastprice	'최종입찰가
	Public currentdt	'디비 현재시간

	Public prodname
	Public sellprice

	Function bidstatus_name()
		Dim retstr
		Select Case bidstatus
			Case "1" retstr = "경매중"
			Case "2" retstr = "경매낙찰"
			Case "3" retstr = "경매유찰"
		End Select
		bidstatus_name = retstr
	End Function
End Class

'-----------------------------------------------------------------------------------------------100
' 게시판 공통 클래스
'-----------------------------------------------------------------------------------------------100
Class clsBoard
	Public boardid
	Public boardtype
	Public boardname
	Public location

	Private o_qna_list		'Q&A 게시물 리스트
	Private o_news_list		'뉴스/공지 게시물 리스트

	Public Property Get qna_list()
		If IsEmpty(o_qna_list) Then
			Set qna_list = new clsList
		Else
			Set qna_list = o_qna_list
		End If
	End Property

	Sub addQna(o_qna)
		If IsEmpty(o_qna_list) Then
			Set o_qna_list = new clsList
		End If
		o_qna_list.add o_qna
		Set o_qna = nothing
	End Sub

	Public Property Get news_list()
		If IsEmpty(o_news_list) Then
			Set news_list = new clsList
		Else
			Set news_list = o_news_list
		End If
	End Property

	Sub addNews(o_news)
		If IsEmpty(o_news_list) Then
			Set o_news_list = new clsList
		End If
		o_news_list.add o_news
		Set o_news = nothing
	End Sub

	Private Sub Class_Terminate
		If IsEmpty(o_qna_list) Then
			Set o_qna_list = nothing
		End If
		If IsEmpty(o_news_list) Then
			Set o_news_list = nothing
		End If
	End Sub
End Class

'-----------------------------------------------------------------------------------------------100
' Q&A 게시물 클래스
'-----------------------------------------------------------------------------------------------100
Class clsQna
	Public boardid
	Public qnaid
	Public title
	Public content
	Public regdt
	Public writer
	Public email
	Public readcnt
	Public passwd
	Public refid
	Public step
	Public depth
	Public prodid
	Public prodeval
	Public custid
	Public useyn

	Public prodname
	Function regdate()
		regdate = ToDate(regdt)
	End Function
End Class

'-----------------------------------------------------------------------------------------------100
' 뉴스/공지 게시물 클래스
'-----------------------------------------------------------------------------------------------100
Class clsNews
	Public boardid
	Public newsid
	Public newskind
	Public linktype
	Public title
	Public content
	Public avalstdt
	Public avalendt
	Public useyn

	Public newskind_name

	Function regdate()
		regdate = fn_str2Date(regdt)
	End Function

	Function linktype_name()
		Dim retstr
		Select Case linktype
			Case "1" retstr = "링크"
			Case "2" retstr = "팝업"
			Case "3" retstr = "자동팝업"
		End Select
		linktype_name = retstr
	End Function
End Class



'--------------------------------------------------------------------------------------------------
' 주문 클래스
'--------------------------------------------------------------------------------------------------
Class clsOrder
	Public orderid
	Public custid
	Public custname
	Public orderdt
	Public payername		'입금자명
	Public orderkind		'주문종류 1:일반, 2:마일리지

	Public rcpttypes	'결제수단 들
	Public orderstatuses	'주문상태 들

	Public prodid		'주문상품 대표 아이디
	Public prodname		'주문상품 대표 이름
	Public prodcnt		'주문상품 개수

	Private o_products		'주문상품 리스트


	Private Sub Class_Initialize
		Set o_products = new clsList
	End Sub

	Public Property Get products()
		Set products = o_products
	End Property

	Sub addProduct(o_prod)
		o_products.add o_prod
		Set o_prod = nothing
	end Sub

	Function hasProduct()
		if o_products.count > 0 then
			hasProduct = true
		else
			hasProduct = false
		end if
	end Function

	'주문 총 가격 ( 상품가+옵션가+배송비)
	Function totalPrice()
		Dim totsellprice
		totsellprice = totalSellprice()

		If totsellprice >= 30000 or orderkind = "2" Then
			totalPrice = totsellprice
		Else
			totalPrice = totsellprice + 3000
		end if
	End Function

	'주문상품 가격 ( 상품가+옵션가)
	Function totalSellprice()
		Dim retvalue, i
		retvalue = 0
		For i = 1 to o_products.count
			retvalue = retvalue + CDbl(o_products.item(i).totalPrice())
		Next
		totalSellprice = retvalue
	End Function

	'주문 배송비
	Function totalShipprice()
		If totalSellprice() >= 30000 or orderkind = "2" Then
			totalShipprice = 0
		Else
			totalShipprice = 3000
		End If
	End Function

	Function totalProdpoint()
		Dim retvalue, i
		retvalue = 0
		For i = 1 to o_products.count
			retvalue = retvalue + CDbl(o_products.item(i).totalProdpoint())
		Next
		totalProdpoint = retvalue
	End Function

	Private Sub Class_Terminate
		Set o_products = nothing
	End Sub
End Class


'--------------------------------------------------------------------------------------------------
' 주문상품 클래스
'--------------------------------------------------------------------------------------------------
Class clsOrderProduct
	Public prodid
	Public prodseq
	Public prodcnt
	Public prodname
	Public prodimage
	Public prodcode
	Public prodspec
	Public sellprice
	Public buyprice
	Public prodpoint
	Public prodkind
	Public shipprice
	Public unitname
	Public orderstatus
	Public sid
	Public Mid
	Public did

	Public orderstatusname
	Public sname
	Public orderstatuses

	Private o_optitems	'주문상품옵션 들

	Private Sub Class_Initialize
		Set o_optitems = new clsList
	End Sub

	Public Property Get optitems()
		Set optitems = o_optitems
	End Property

	Sub addOptionItem(o_item)
		o_optitems.add o_item
		Set o_item = nothing
	end Sub

	Function hasOptionItem()
		if o_optitems.count > 0 then
			hasOptionItem = true
		else
			hasOptionItem = false
		end if
	end Function

	Function optionPrice()
		Dim retvalue, i
		retvalue = 0
		For i = 1 to o_optitems.count
			retvalue = retvalue + CDbl(o_optitems.item(i).sellprice)
		Next
		optionPrice = retvalue * CDbl(prodcnt)
	End Function

	Function totalShipprice()
		totalShipprice = 0		'CDbl(shipprice) * CDbl(prodcnt)
	End Function

	Function totalProdpoint()
		totalProdpoint = CDbl(prodpoint) * CDbl(prodcnt)
	End Function

	Function totalPrice()
		Dim retvalue, i
		retvalue = CDbl(sellprice) + 0	'CDbl(shipprice)
		For i = 1 to o_optitems.count
			retvalue = retvalue + CDbl(o_optitems.item(i).sellprice)
		Next
		totalPrice = retvalue * CDbl(prodcnt)
	End Function

	Private Sub Class_Terminate
		Set o_optitems = nothing
	End Sub
End Class

'--------------------------------------------------------------------------------------------------
' 주문상품옵션아이템 클래스
'--------------------------------------------------------------------------------------------------
Class clsOrderProdOptionItem
	Public optname			'옵션명
	Public itemname			'옵션항목명
	Public sellprice		'옵션항목 판매가
	Public buyprice			'옵션항목 매입가
End Class


'--------------------------------------------------------------------------------------------------
' 회원정보 클래스
'--------------------------------------------------------------------------------------------------
Class clsCustomer
	Public custid
	Public custname
	Public custtype
	Public custkind
	Public loginid
	Public passwd
	Public passwdque
	Public passwdans
	Public address
	Public zipcode
	Public email
	Public emailrcptyn
	Public lastpoint
	Public gender
	Public solarlunar
	Public birthday
	Public ssn
	Public phone1
	Public phone2
	Public phone3
	Public hobbies
	Public job
	Public scholar
	Public marryyn
	Public marrydt
	Public coname
	Public codept
	Public copos
	Public cozip
	Public coaddr
	Public ename
	Public partnerid
	Public friendid
	Public joindt
	Public outdt
	Public useyn
	Public staffid

	'아이핀으로 인한 추가 (2010.03.02  박선화)
	Public ipinyn
	Public ipinbirth

	'사원여부 (2011.08.01 박선화)
	Public sj_member

	'암호화값 (2011.10.26 박선화)
	Public custDi

End Class


Class clsShopName
	Public	idx
	Public	s_name
End Class
%>
