<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="paging" style="font-size:120%; font-weight:bold; text-align: center">
			<c:url var="action" value="${param.command}" />
			<c:if test="${paging.prev}">
				<a href="${action}?page=${paging.beginPage-1}">◀</a>&nbsp;
			</c:if>
			<c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
				<c:choose>
					<c:when test="${paging.page==index}">
						<span style="color:red">${index}&nbsp;</span>
					</c:when>
					<c:otherwise>
						<a href="${action}?page=${index}">${index}</a>&nbsp;
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.next}">
				<a href="${action}?page=${paging.endPage+1}">▶</a>&nbsp;
			</c:if>
	</div>
