<%@ page language="java" contentType="text/HTML;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/header/header.jsp" %>
<%@ page session="false" %>
<%--글 인덱스로 넘어가는 페이지--%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="apple-mobile-web-app-capable" content="yes"/>
        <meta name="mobile-web-app-capable" content="yes"/>
        <title>글쓰기 확인</title>
        <link rel="stylesheet" href="/resources/app/stat/writing.css"/>
        <link rel="stylesheet" href="/resources/app/stat/layout.css"/>
        <script src="/resources/app/javascript/write.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

    </head>
    <body>
        <header>
            <div class="header-layout">

                <h1 class="header__title"><a href="/logout" title="홈으로">LOG-OUT</a></h1>

                <nav class="header__tabs">
                    <a class="item" href="/firstwrite">
                        <svg class="item-icon" height="24" viewBox="0 0 24 24" width="24">
                            <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/>
                            <path d="M0 0h24v24H0z" fill="none"/>
                        </svg>
                        <span class="item-span">글쓰기</span>
                    </a>

                    <a class="item" href="/library">
                        <svg class="item-icon" height="24" viewBox="0 0 24 24" width="24">
                            <path d="M0 0h24v24H0z" fill="none"/>
                            <path d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-1 9H9V9h10v2zm-4 4H9v-2h6v2zm4-8H9V5h10v2z"/>
                        </svg>
                        <span class="item-span">라이브러리</span>
                    </a>


                    <a class="item" href="/newsfeed">
                        <svg class="item-icon" height="24" viewBox="0 0 24 24" width="24">
                            <path d="M12 10.9c-.61 0-1.1.49-1.1 1.1s.49 1.1 1.1 1.1c.61 0 1.1-.49 1.1-1.1s-.49-1.1-1.1-1.1zM12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm2.19 12.19L6 18l3.81-8.19L18 6l-3.81 8.19z"/>
                            <path d="M0 0h24v24H0z" fill="none"/>
                        </svg>
                        <span class="item-span">뉴스피드</span>

                    </a>

                    <span class="item-span">${author}</span>
                </nav>

            </div>
        </header>

        <main id="js--body" class="body-layout card-list">

            <link rel="stylesheet" href="/resources/app/stat/writing.css"/>

            <div class="raised-button-list nocard">
                <button id="js--new-create" class="raised-button inactive" value=${size}>checking...</button>
                <button id="js--new-get" class="raised-button">글 받아오기</button>
            </div>

            <%--일감 내용--%>
            <c:forEach items="${BoardVO}" var="BoardVO">
            <a id="${BoardVO.author_id}" class="js--card card" style="display: block;" href="<spring:url value="/writing?idx=${BoardVO.idx}&author_id=${BoardVO.author_id}"/>">
                <div class="primary-header">
                    <h2 class="primary-text">${BoardVO.author}</h2>
                    <time class="js--time sub-title" datetime="${BoardVO.datatime}">${BoardVO.datatime}</time>
                    <span class="chip">
                        <i class="chip-icon">
                            <svg class="chip-icon__svg" height="24" viewBox="0 0 24 24" width="24">
                                <path d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"/>
                                <path d="M0 0h24v24H0z" fill="none"/>
                                <path d="M12.5 7H11v6l5.25 3.15.75-1.23-4.5-2.67z"/>
                            </svg>
                        </i>
                        <span class="js--timer chip-timer">calculating...</span>
                    </span>
                </div>
                <div class="sub-text">${BoardVO.content}</div>
                <input type="hidden" id = "${BoardVO.pre_author_id}" value= "${BoardVO.pre_author_id}" />
                <input type="hidden" id="remove" value="${BoardVO.idx}"/>
            </a>
            </c:forEach>


            <!-- get Scr size for template -->
            <script>
                function a() {
                var a = window.innerWidth;
                if (a <= 360) {
                document.body.className = 'xs';
                } else if (a <= 600) {
                document.body.className = 's';
                } else {
                document.body.className = 'm';
                }
                }
                a();
                window.addEventListener('resize', a);
            </script>
            <script>
                function updateButtons(add) {
                if (add == undefined) {
                add = 0;
                }
                let cards = document.getElementsByClassName('js--card'),
                btn_create = document.getElementById('js--new-create'),
                btn_get = document.getElementById('js--new-get');
                // Update Create-New button
                let recent_contributes = parseInt(btn_create.value) + add;
                btn_create.value = recent_contributes;
                if (recent_contributes < 3) {
                btn_create.innerHTML = recent_contributes + '/3';
                btn_create.classList.add('inactive');
                } else {
                btn_create.innerHTML = '제시문 작성하기';
                if (cards.length >= 3) {
                btn_create.classList.add('inactive');
                } else {
                btn_create.classList.remove('inactive');
                }
                }
                // Update Get-New button
                if (cards.length >= 3) {
                btn_get.classList.add('inactive');
                } else {
                btn_get.classList.remove('inactive');
                }
                }
                updateButtons();
                function newContent() {
                try {
                const xhttp = new XMLHttpRequest();
                let url = '/reqthread/';
                xhttp.open('POST', url, true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=UTF-8");
                xhttp.send();
                xhttp.onreadystatechange = function() {
                if (xhttp.readyState == 4) {
                if (xhttp.status != 200) {
                console.log('error code: ' + xhttp.status);
                } else {
                const thread = JSON.parse(xhttp.responseText);
                var template = document.createElement('a');
                template.id = thread.thread_id;
                template.className = 'js--card card';
                template.style.display = 'block';
                template.href = '/writing/?idx=' + thread.idx;
                template.innerHTML = '<div class="primary-header"><h2 class="primary-text">'
                + thread.author.name + '</h2><time class="js--time sub-title" datetime="'
                    + thread.datetime + '">'
                + thread.date + '</time><span class="chip"><i class="chip-icon"><svg class="chip-icon__svg" height="24" viewBox="0 0 24 24" width="24"><path d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"/><path d="M0 0h24v24H0z" fill="none"/><path d="M12.5 7H11v6l5.25 3.15.75-1.23-4.5-2.67z"/></svg></i><span class="js--timer chip-timer">calculating...</span></span></div><div class="sub-text">'
                + thread.content + '</div>';
                document.getElementById('js--body').appendChild(template);
                dueCheck.render();
                updateButtons(1);
                }
                }
                }
                } catch (err) {
                console.log(err);
                }
                }
                document.getElementById('js--new-get').addEventListener('click', newContent);
                var dueCheck = function() {
                let list = new Array();
                return {
                render: function() {
                list = [];
                let cards = document.getElementsByClassName('js--card');
                function getTimeKST(datetime) {
                datetime = datetime.split(' ');
                if (datetime[4] == 'KST') {
                // Day Month Date HH:MM:SS KST YYYY -> Day Month Date YYYY HH:MM:SS GMT+0900 (KST)
                datetime =  datetime[0] + ' ' + datetime[1] + ' ' + datetime[2] + ' ' + datetime[5] + ' ' + datetime[3] + ' GMT+0900 (KST)';
                } else {
                datetime = datetime.join('');
                }
                return Date.parse(datetime);
                }
                [].map.call(cards, function(card) {
                list.push({
                id: card.id,
                date: new Date(getTimeKST(document.querySelector('#' + card.id + ' .js--time').getAttribute('datetime'))),
                timer: document.querySelector('#' + card.id + ' .js--timer')
                });
                });
                },
                update: function() {
                let date = new Date();
                list.map(function(card) {
                let remainSecs = Math.round(((3 * 8640000)- date.getTime() + card.date.getTime())/1000);
                if (remainSecs <= 0) {
                card.timer.innerHTML = 'DUE END';
                dueCheck.removeCard(card.id);
                return;
                }
                let timer = '';
                if (remainSecs >= 86400) {
                timer += Math.floor(remainSecs/86400) + 'D';
                remainSecs -= Math.floor(remainSecs/86400)*86400;
                if (remainSecs >= 3600) {
                timer += ' ' + Math.floor(remainSecs/3600) + 'H';
                remainSecs -= Math.floor(remainSecs/3600)*3600;
                }
                if (remainSecs >= 60) {
                timer += ' ' + Math.floor(remainSecs/60) + 'M';
                }
                } else {
                if (remainSecs >= 3600) {
                timer += Math.floor(remainSecs/3600) + 'H';
                remainSecs -= Math.floor(remainSecs/3600)*3600;
                }
                if (remainSecs >= 60) {
                timer += ' ' + Math.floor(remainSecs/60) + 'M';
                remainSecs -= Math.floor(remainSecs/60)*60;
                }
                if (remainSecs > 0) {
                timer += ' ' + remainSecs + 'S';
                }
                }
                if (card.timer.innerHTML != timer) {
                card.timer.innerHTML = timer;
                }
                });
                },
                removeCard: function(id) {
                let target = document.getElementById(id);
                console.log('card id: ' + id + 'has been discarded');
                target.classList.remove('js--card');
                target.href = '#';
                dueCheck.render();
                updateButtons();
                target.addEventListener('click', function() {
                target.style.maxHeight = target.getBoundingClientRect().height + 'px';
                target.style.transition = 'transform .5s ease-in, opacity .5s linear, margin-top .35s ease, max-height .35s ease';
                target.style.opacity = '0';
                target.style.transform = 'translateX(100%)';
                setTimeout(function() {
                target.style.maxHeight = '0';
                target.classList.remove('card');
                target.style.marginTop = '0';
                }, 500);
                setTimeout(function() {
                document.getElementById('js--body').removeChild(target);
                }, 20000);
                });
                }
                }
                }();
                window.setInterval(dueCheck.update, 1000);
                dueCheck.render();
            </script>

        </main>
    </body>
</html>