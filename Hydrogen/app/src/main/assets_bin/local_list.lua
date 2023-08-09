require "import"
import "mods.muk"
import "com.lua.*"

activity.setContentView(loadlayout("layout/local_list"))

初始化历史记录数据(true)


波纹({fh,_more},"圆主题")
_title.Text="已保存的内容"

local_item=获取适配器项目布局("local_item/local_item")


if not 文件是否存在(内置存储文件()) then
  xpcall(function()
    创建文件夹(内置存储文件())
  end,function()
  end)
end
if not 文件是否存在(内置存储文件("Download")) then
  xpcall(function()
    创建文件夹(内置存储文件("Download"))
  end,function()
  end)
end

notedata={}
noteadp=LuaAdapter(activity,notedata,local_item)
local_listview.setAdapter(noteadp)

mytab={"全部","回答","想法","文章","视频"}
for i,v in ipairs(mytab) do
  localtab:addTab(v,function() pcall(function()noteadp.clear()end) 加载笔记(v) mystr=v noteadp.notifyDataSetChanged() end,3)
end
localtab:showTab(1)

function 加载笔记(str)
  if #luajava.astable(File(内置存储文件("Download")).listFiles())==0 then
    localtab.ids.load.parent.setVisibility(8)
    empty.setVisibility(0)
    return false
  end

  if str =="全部" or str==nil then
    str="all"
   elseif str =="回答" then
    str="answer_id"
   elseif str=="想法" then
    str="pin"
   elseif str=="文章" then
    str="article"
   elseif str=="视频" then
    str="video"
  end

  notedata={}
  if str == "all" then
    for i,v in ipairs(luajava.astable(File(内置存储文件("Download")).listFiles())) do
      local vv=v
      local v=tostring(v)
      local _,name=v:match("(.+)/(.+)")
      notedata[#notedata+1]={
        timestamp=vv.lastModified(),
        catitle=name,
        file=(v),
      }
    end

    table.sort(notedata,function(a, b)
      return a.timestamp > b.timestamp
    end)
   else

    for i,v in ipairs(luajava.astable(File(内置存储文件("Download")).listFiles())) do
      local vv=v
      local v=tostring(v)
      local a=luajava.astable(File(v).listFiles())
      local bbb=tostring(a[1]).."/detail.txt"
      local filestr=读取文件(bbb)
      local _,name=v:match("(.+)/(.+)")
      if filestr:find(str) then
        notedata[#notedata+1]={
          timestamp=vv.lastModified(),
          catitle=name,
          --    cid=name,
          file=(v),
        }
      end
    end
  end

  table.sort(notedata,function(a, b)
    return a.timestamp > b.timestamp
  end)

  noteadp=LuaAdapter(activity,notedata,local_item)
  local_listview.setAdapter(noteadp)
end

加载笔记()

function checktitle(str)
  local oridata=noteadp.getData()

  for b=1,2 do
    if b==2 then
      提示("搜索完毕 共搜索到"..#noteadp.getData().."条数据")
      if #noteadp.getData()==0 then
        加载笔记(mystr)
      end
    end
    for i=#oridata,1,-1 do
      if not oridata[i].catitle:find(str) then
        table.remove(oridata, i)
        noteadp.notifyDataSetChanged()
      end
    end
  end
end

local_listview.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(id,v,zero,one)
    本地列表(v.Tag.catitle.Text)
end})

local_listview.setOnItemLongClickListener(AdapterView.OnItemLongClickListener{
  onItemLongClick=function(id,v,zero,one)
    双按钮对话框("删除","删除该内容？该操作不可撤消！","是的","点错了",function()删除文件(内置存储文件("Download/"..v.Tag.catitle.Text))
      an.dismiss()
      加载笔记(mystr)
      提示("已删除")end,function()an.dismiss()end)
    return true
end})

function 本地列表(path)
  if 全局主题值=="Day" then
    bwz=0x3f000000
   else
    bwz=0x3fffffff
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      id="ztbj";
      {
        CardView;
        layout_gravity="center",
        background=cardedge,
        radius="3dp",
        Elevation="0dp";
        layout_height="6dp",
        layout_width="56dp",
        layout_marginTop="12dp";
      };
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text="选择作者";
        Typeface=字体("product-Bold");
        textColor=primaryc;
      };
      {
        ListView;
        padding="8dp",
        layout_width="-1";
        layout_height="-1";
        id="listview",
      };
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="2dp";
          background="#00000000";
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginBottom="24dp";
          Elevation="0";
          onClick=qxnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            Typeface=字体("product-Bold");
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text=qx;
            textColor=stextc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          CardBackgroundColor=primaryc;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=qdnr;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            Typeface=字体("product-Bold");
            paddingTop="8dp";
            paddingBottom="8dp";
            Text="关闭";
            onClick=function()
              an.dismiss()
            end,

            textColor=backgroundc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };
  local bottomSheetDialog = BottomSheetDialog(this)
  bottomSheetDialog.setContentView(loadlayout(dann))
  an=bottomSheetDialog.show()
  datas={}
  for v,s in pairs(luajava.astable(File(内置存储文件("Download/"..path.."/")).listFiles())) do
    table.insert(datas,s.Name)
  end
  array_adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1,String(datas))
  --设置适配器
  listview.setAdapter(array_adp)

  listview.setOnItemClickListener(AdapterView.OnItemClickListener{
    onItemClick=function(id,v,zero,one)
      --    print(path,v.Text)
      activity.newActivity("local",{path,v.Text})
      an.dismiss()
  end})

end

task(1,function()
  a=MUKPopu({
    tittle="已保存的回答",
    list={
      {
        src=图标("search"),text="搜索已保存的回答",onClick=function()
          InputLayout={
            LinearLayout;
            orientation="vertical";
            Focusable=true,
            FocusableInTouchMode=true,
            {
              EditText;
              hint="输入";
              layout_marginTop="5dp";
              layout_marginLeft="10dp",
              layout_marginRight="10dp",
              layout_width="match_parent";
              layout_gravity="center",
              id="edit";
            };
          };

          AlertDialog.Builder(this)
          .setTitle("请输入")
          .setView(loadlayout(InputLayout))
          .setPositiveButton("确定", {onClick=function() checktitle(edit.text) end})
          .setNegativeButton("取消", nil)
          .show();

      end},
      {src=图标("email"),text="反馈",onClick=function()
          activity.newActivity("feedback")
      end},
      {src=图标("info"),text="导入",onClick=function()
          if Build.VERSION.SDK_INT <30 then
            return 提示("该功能只提供安卓10以上版本使用")
          end

          local result=get_write_permissions()
          if result~=true then
            return false
          end

          import "android.widget.ArrayAdapter"
          import "android.widget.LinearLayout"
          import "android.widget.TextView"
          import "java.io.File"
          import "android.widget.ListView"
          import "android.app.AlertDialog"
          function ChoicePath(StartPath,callback)
            --创建ListView作为文件列表
            lv=ListView(activity).setFastScrollEnabled(true)
            --创建路径标签
            cp=TextView(activity)
            lay=LinearLayout(activity).setOrientation(1).addView(cp).addView(lv)
            ChoiceFile_dialog=AlertDialog.Builder(activity)--创建对话框
            .setTitle("选择路径")
            .setPositiveButton("确认",nil)
            .setNegativeButton("取消",nil)
            .setCancelable(false)
            .setView(lay)
            .show()
            ChoiceFile_dialog.getButton(ChoiceFile_dialog.BUTTON_POSITIVE).onClick=function()
              AlertDialog.Builder(activity)--创建对话框
              .setTitle("确定吗 选择错误可能会导致软件过大 如选择错误后 请打开应用设置中的管理android/data目录自行删除多余文件")
              .setPositiveButton("确认",{onClick=function() callback(tostring(cp.Text)) ChoiceFile_dialog.dismiss() end})
              .setNegativeButton("取消",nil)
              .setCancelable(false)
              .show()
            end
            adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
            lv.setAdapter(adp)
            function SetItem(path)
              path=tostring(path)
              adp.clear()--清空适配器
              cp.Text=tostring(path)--设置当前路径
              if path~="/" then--不是根目录则加上../
                adp.add("../")
              end
              ls=File(path).listFiles()
              if ls~=nil then
                ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
                table.sort(ls,function(a,b)
                  return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
                end)
               else
                ls={}
              end
              for index,c in ipairs(ls) do
                if c.isDirectory() then--如果是文件夹则
                  adp.add(c.Name.."/")
                end
              end
            end
            lv.onItemClick=function(l,v,p,s)--列表点击事件
              项目=tostring(v.Text)
              if tostring(cp.Text)=="/" then
                路径=ls[p+1]
               else
                路径=ls[p]
              end

              if 项目=="../" then
                SetItem(File(cp.Text).getParentFile())
               elseif 路径.isDirectory() then
                SetItem(路径)
               elseif 路径.isFile() then
                callback(tostring(路径))
                ChoiceFile_dialog.hide()
              end

            end

            SetItem(StartPath)
          end


          import "android.os.*"
          ChoicePath(Environment.getExternalStorageDirectory().toString(),
          function(path)
            LuaUtil.copyDir(File(path),File(activity.getExternalFilesDir(nil).toString().."/Hydrogen"))
            提示("导入成功")
          end)

      end},
      {src=图标("info"),text="导出",onClick=function()
          if Build.VERSION.SDK_INT <30 then
            return 提示("该功能只提供安卓10以上版本使用")
          end

          local result=get_write_permissions()
          if result~=true then
            return false
          end

          LuaUtil.copyDir(File(activity.getExternalFilesDir(nil).toString().."/Hydrogen"),File(Environment.getExternalStorageDirectory().toString().."/Hydrogen"))
          提示("导出成功,导出目录在"..Environment.getExternalStorageDirectory().toString().."/".."Hydrogen")
      end},
      {src=图标("info"),text="问题",onClick=function()
          Snakebar("文件保存在"..内置存储("Hydrogen/download"))
      end},
    }
  })
end)