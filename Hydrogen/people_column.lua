require "import"
import "mods.muk"
activity.setContentView(loadlayout("layout/history"))


波纹({fh,_more},"圆主题")

初始化历史记录数据(true)

id,title=...
if activity.getSharedData("标题简略化")~="true" then
  _title.text=title
 else
  _title.text="专栏"
end
_more.setVisibility(8)
tabv.setVisibility(8)
itemc=
{
  LinearLayout;
  layout_width="-1";
  orientation="horizontal";
  --background=backgroundc,
  BackgroundColor=backgroundc;
  {
    CardView;
    layout_gravity="center";
    layout_height="-2";
    CardBackgroundColor=cardedge,
    Elevation="0";
    layout_width="-1";
    layout_margin="0dp";
    layout_marginTop="0dp";
    layout_marginBottom="0dp";
    radius="0dp";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=backgroundc;
      Radius="0dp";
--      layout_margin="4px";
      layout_margin=cardmargin;
      layout_width="-1";
      layout_height="-1";
      {
        LinearLayout;
        layout_height="fill";
        id="background";
        layout_width="fill";
        ripple="圆自适应",

        {
          LinearLayout;
          orientation="horizontal";
          padding="24dp";
          paddingTop="18dp";
          paddingBottom="18dp";
          {
            TextView;
            id="people_url";
            textSize="0sp";
          };
          {
            LinearLayout;
            orientation="vertical";
            {
              LinearLayout;
              orientation="horizontal";
              {
                CircleImageView;
                layout_width="20dp",
                layout_height="20dp",
                id="people_image",
              };
              {
                TextView;
                id="people_action";
                layout_marginLeft="6dp",
                textColor=stextc;
                layout_gravity="center_vertical",
                Typeface=字体("product");
                textSize="12sp";
              };
              {
                TextView;
                id="people_question";
                textSize="0sp";
              };

            };
            {
              TextView;
              textSize="14sp";
              id="people_title";
              textColor=textc;
              letterSpacing="0.02";
              layout_marginTop="8dp";
              Typeface=字体("product-Bold");

            };
            {
              TextView;
              textSize="12sp";
              id="people_art";
              textColor=stextc;
              MaxLines=3;--设置最大输入行数
              letterSpacing="0.02";
              ellipsize="end",
              layout_marginTop="8dp";
              Typeface=字体("product");
            };
            {
              LinearLayout;
              layout_marginTop="8dp";
              orientation="horizontal";
              id="people_palne",
              {
                ImageView;
                src=图标("vote_up"),
                ColorFilter=textc;
                layout_height="16dp",
                layout_width="16dp",
              };
              {
                TextView;
                id="people_vote";
                layout_marginLeft="6dp",
                textColor=textc;
                textSize="12sp";
                Typeface=字体("product");
              };
              {
                ImageView;
                layout_marginLeft="24dp",
                src=图标("message"),
                ColorFilter=textc;
                layout_height="16dp",
                layout_width="16dp",
              };
              {
                TextView;
                layout_marginLeft="6dp",
                textSize="12sp";
                id="people_comment";
                textColor=textc;
                Typeface=字体("product");
              };
            };
          };
        };
      };
    };
  };
};





adp=LuaAdapter(activity,itemc)

history_list.Adapter=adp

isaddd=true
history_list.setOnScrollListener{
  onScroll=function(view,a,b,c)
    if a+b==adp.getCount() and isaddd and adp.getCount()>0 then
      isaddd=false
      刷新()
      System.gc()
    end
  end
}

function 刷新()
  geturl=myurl or "https://api.zhihu.com/columns/"..id.."/items"


  Http.get(geturl,head,function(code,content)
    if code==200 then
      if require "cjson".decode(content).paging.next then
        testurl=require "cjson".decode(content).paging.next
        if testurl:find("http://") then
          testurl=string.gsub(testurl,"http://","https://",1)
        end
        myurl=testurl
      end
      if require "cjson".decode(content).paging.is_end and isclear~="clear" then
        提示("已经没有更多内容了")
       else
        提示("加载中")
      end
      for i,v in ipairs(require "cjson".decode(content).data) do
        --  local 预览内容=v.excerpt_new
        local 头像=v.author.avatar_url
        local 预览内容=v.excerpt
        local 点赞数=tointeger(v.voteup_count)
        local 评论数=tointeger(v.comment_count)
        if v.type=="answer" then
          活动="回答了问题"
          问题id=tointeger(v.question.id or 1).."分割"..tointeger(v.id)
          标题=v.question.title
         elseif v.type=="topic" then
          people_list.Adapter.add{people_action=活动,people_art={Visibility=8},people_palne={Visibility=8},people_comment={Visibility=8},people_question="话题分割"..v.id,people_title=v.name,people_image=头像}
          return
         elseif v.type=="question" then
          活动="发布了问题"
          问题id=tointeger(v.id or 1).."问题分割"
          标题=v.title
         elseif v.type=="column" then
          活动="发表了专栏"
          问题id="文章分割"..v.id
          评论数=tointeger(v.items_count)
          标题=v.title

         elseif v.type=="collection" then
          return
         elseif v.type=="pin" then
          活动="发布了想法"
          标题=v.author.name.."发布了想法"
          问题id="想法分割"..v.id
          预览内容=v.content[1].content
         elseif v.type=="zvideo" then
          --视频并未直接暴露在接口内 需自己根据api获取视频链接
          活动="发布了视频"
          问题id="视频分割"..v.id
          标题=v.title
         else
          活动="发表了文章"
          问题id="文章分割"..tointeger(v.id)
          标题=v.title
        end
        history_list.Adapter.add{people_action=活动,people_art=预览内容,people_vote=点赞数,people_comment=评论数,people_question=问题id,people_title=标题,people_image=头像}
      end
      isaddd=true
    end
  end)
end

刷新()

history_list.onItemClick=function(l,v,c,b)
  local open=activity.getSharedData("内部浏览器查看回答")
  if tostring(v.Tag.people_question.text):find("文章分割") then
    activity.newActivity("column",{tostring(v.Tag.people_question.Text):match("文章分割(.+)"),tostring(v.Tag.people_question.Text):match("分割(.+)")})
   elseif tostring(v.Tag.people_question.text):find("话题分割") then
    activity.newActivity("huida",{"https://www.zhihu.com/topic/"..tostring(v.Tag.people_question.Text):match("话题分割(.+)")})
   elseif tostring(v.Tag.people_question.text):find("问题分割") then
    activity.newActivity("question",{tostring(v.Tag.people_question.Text):match("(.+)问题分割")})
   elseif tostring(v.Tag.people_question.text):find("想法分割") then
    activity.newActivity("column",{tostring(v.Tag.people_question.Text):match("想法分割(.+)"),"想法"})
   elseif tostring(v.Tag.people_question.Text):find("视频分割") then
    activity.newActivity("column",{tostring(v.Tag.people_question.Text):match("视频分割(.+)"),"视频"})
   elseif tostring(v.Tag.people_question.Text):find("专栏分割") then
    activity.newActivity("people_column",{tostring(v.Tag.people_question.Text):match("专栏分割(.+)专栏标题"),tostring(v.Tag.people_question.Text):match("专栏标题(.+)")})
   else
    if open=="false" then
      保存历史记录(v.Tag.people_title.Text,v.Tag.people_url.Text,50)
      activity.newActivity("answer",{tostring(v.Tag.people_question.Text):match("(.+)分割"),tostring(v.Tag.people_question.Text):match("分割(.+)")})
     else
      activity.newActivity("huida",{"https://www.zhihu.com/question/"..tostring(v.Tag.follow_id.Text):match("(.+)分割").."/answer/"..tostring(v.Tag.follow_id.Text):match("分割(.+)")})
    end
  end
end
