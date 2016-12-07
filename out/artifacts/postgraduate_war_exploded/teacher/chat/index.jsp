<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
<style>
    *, *:before, *:after {
        box-sizing: border-box;
    }

    #chat {
        margin: 20px auto;
        width: 800px;
        height: 600px;
    }
</style>

<style type="text/css">#chat {
    overflow: hidden;
    border-radius: 3px
}

#chat .main, #chat .sidebar {
    height: 100%
}

#chat .sidebar {
    float: left;
    width: 200px;
    color: #f4f4f4;
    background-color: #2e3238
}

#chat .main {
    position: relative;
    overflow: hidden;
    background-color: #eee
}

#chat .m-text {
    position: absolute;
    width: 100%;
    bottom: 0;
    left: 0
}

#chat .m-message {
    height: calc(100% - 10pc)
}

</style>

<style type="text/css">

.m-card {
    padding: 9pt;
    border-bottom: 1px solid #24272c
}

.m-card footer {
    margin-top: 10px
}

.m-card .avatar, .m-card .name {
    vertical-align: middle
}

.m-card .avatar {
    border-radius: 2px
}

.m-card .name {
    display: inline-block;
    font-style: italic;
    margin: 0 0 0 15px;
    font-size: 1pc
}

.m-card .search {
    padding: 0 10px;
    width: 100%;
    font-size: 9pt;
    color: #fff;
    height: 30px;
    line-height: 30px;
    border: 1px solid #3a3a3a;
    border-radius: 4px;
    outline: 0;
    background-color: #26292e
}</style>

<style type="text/css">

.m-list li {
    padding: 9pt 15px;
    border-bottom: 1px solid #292c33;
    cursor: pointer;
    -webkit-transition: background-color .1s;
    transition: background-color .1s
}

.m-list li:hover {
    background-color: hsla(0, 0%, 100%, .03)
}

.m-list li.active {
    background-color: hsla(0, 0%, 100%, .1)
}

.m-list .avatar, .m-list .name {
    vertical-align: middle
}

.m-list .avatar {
    border-radius: 2px
}

.m-list .name {
    display: inline-block;
    margin: 0 0 0 15px
}</style>

<style type="text/css">

.m-text {
    height: 10pc;
    border-top: 1px solid #ddd
}

.m-text textarea {
    padding: 10px;
    height: 100%;
    width: 100%;
    /*border: #c3deb7;*/
    outline: 0;
    font-family: Micrsofot Yahei;
    resize: none
}</style>

<style type="text/css">

.m-message {
    padding: 10px 15px;
    overflow-y: scroll
}

.m-message li {
    margin-bottom: 15px
}

.m-message .time {
    margin: 7px 0;
    text-align: center
}

.m-message .time > span {
    display: inline-block;
    padding: 0 18px;
    font-size: 9pt;
    color: #fff;
    border-radius: 2px;
    background-color: #dcdcdc
}

.m-message .avatar {
    float: left;
    margin: 0 10px 0 0;
    border-radius: 3px
}

.m-message .text {
    display: inline-block;
    position: relative;
    padding: 0 10px;
    max-width: calc(100% - 40px);
    min-height: 30px;
    line-height: 2.5;
    font-size: 9pt;
    text-align: left;
    word-break: break-all;
    background-color: #fafafa;
    border-radius: 4px
}

.m-message .text:before {
    content: " ";
    position: absolute;
    top: 9px;
    right: 100%;
    border: 6px solid transparent;
    border-right-color: #fafafa
}

.m-message .self {
    text-align: right
}

.m-message .self .avatar {
    float: right;
    margin: 0 0 0 10px
}

.m-message .self .text {
    background-color: #b2e281
}

.m-message .self .text:before {
    right: inherit;
    left: 100%;
    border-right-color: transparent;
    border-left-color: #b2e281
}
</style>

    <div id="chat">
        <div class="sidebar">
            <div class="m-card">
                <header><img class="avatar" width="40" height="40" alt="Coffce" src="/teacher/chat/dist/images/1.jpg">
                    <p class="name"><s:property value="teacher.name" /> </p></header>
                <footer><input class="search" placeholder="search user..."></footer>
            </div><!--v-component-->

            <div class="m-list">
                <ul><!--v-for-start-->
                    <s:iterator value="students">
                        <li class="student-list" id="<s:property value="stuId" />">
                            <img class="avatar" width="30" height="30" alt="示例介绍"
                                                src="/teacher/chat/dist/images/2.png">
                            <p class="name"><s:property value="name" /></p></li>
                    </s:iterator>
                </ul>
            </div><!--v-component-->

        </div>

        <div class="main">
            <div class="m-message">
                <ul>
                    <s:iterator value="msgs">
                        <li><p class="time"><span><s:property value="lastDate" /></span></p>
                            <div class="main <s:if test="flag==1" >self</s:if>">
                                <s:if test="flag==1">
                                    <img class="avatar" width="30" height="30" src="/teacher/chat/dist/images/2.png">
                                </s:if>
                                <s:else>
                                    <img class="avatar" width="30" height="30" src="/teacher/chat/dist/images/1.jpg">
                                </s:else>
                                <div class="text"><s:property value="main" /></div>
                            </div>
                        </li>
                    </s:iterator>
                </ul>
            </div>
            <div class="m-text"><textarea placeholder="按 Ctrl + Enter 发送"></textarea></div>
        </div>
    </div>
    <%--<script src="teacher/chat/dist/vue.js.old"></script>--%>
<%--<script src="teacher/chat/src/main.js.old"></script>--%>

</div>

<script src="/bootstrap/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("li.student-list").click(function () {
            var stu_id = this.getAttribute("id");
            var li = $("li.active");
            for(var i =0; i<li.length; i++)
                li[i].className = "student-list";
            this.className = "student-list active";

        });
    })
</script>