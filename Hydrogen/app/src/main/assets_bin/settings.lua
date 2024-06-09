require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
import "mods.muk"
import "com.google.android.material.materialswitch.MaterialSwitch"
设置视图("layout/settings")
设置toolbar(toolbar)

import "com.google.android.material.slider.Slider"
import "com.google.android.material.slider.LabelFormatter"

function clear()
  清理内存()
end

mtip=false

data = {

  {__type=1,title="浏览设置"},

--  {__type=4,subtitle="内部浏览器查看回答",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("内部浏览器查看回答"))}},
  {__type=4,subtitle="自动打开剪贴板上的知乎链接",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("自动打开剪贴板上的知乎链接"))}},

  {__type=4,subtitle="夜间模式追随系统",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("Setting_Auto_Night_Mode"))}},
  {__type=4,subtitle="夜间模式",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("Setting_Night_Mode"))}},

  {__type=4,subtitle="回答预加载(beta)",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("回答预加载(beta)"))}},
  {__type=4,subtitle="标题简略化",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("标题简略化"))}},
  {__type=4,subtitle="不加载图片",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("不加载图片"))}},
  {__type=5,subtitle="字体大小",image=图标(""),status={
      valueFrom=10,
      value=tonumber(activity.getSharedData("font_size")),
      valueTo=30,
      LabelFormatter=LabelFormatter{
        getFormattedValue=function(value)
          local formattedNumber = string.format("%.0f", value)
          activity.setResult(1200,nil)
          activity.setSharedData("font_size",formattedNumber.."")
          if mtip==false then
            提示("更改字号后 推荐重启App获得更好的体验")
            mtip=true
          end
          return formattedNumber.." sp"
        end,
      },

  }},

  {__type=4,subtitle="全屏模式",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("全屏模式"))}},
  {__type=4,subtitle="代码块自动换行",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("代码块自动换行"))}},
  {__type=4,subtitle="关闭硬件加速",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("关闭硬件加速"))}},

  {__type=1,title="主页设置",image=图标("")},

  {__type=4,subtitle="开启想法",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("开启想法"))}},
  {__type=4,subtitle="热榜关闭图片",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("热榜关闭图片"))}},
  {__type=4,subtitle="热榜关闭热度",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("热榜关闭热度"))}},
  {__type=3,subtitle="设置默认主页",image=图标("")},
  {__type=3,subtitle="修改主页排序",image=图标("")},


  {__type=1,title="缓存设置",image=图标("")},

  {__type=4,subtitle="自动清理缓存",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("自动清理缓存"))}},
  {__type=4,subtitle="禁用大部分缓存",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("禁用缓存"))}},
  {__type=3,subtitle="清理软件缓存",image=图标("")},

  {__type=1,title="页面设置"},
  {__type=3,subtitle="主题设置",image=图标("")},

  {__type=1,title="其他"},
  {__type=3,subtitle="关于",image=图标("")},
  {__type=3,subtitle="管理/android/data存储",image=图标("")},
  {__type=3,subtitle="手动填写token",image=图标("")},
  {__type=4,subtitle="音量键切换",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("音量键选择tab"))}},
  {__type=4,subtitle="显示虚拟滑动按键",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("显示虚拟滑动按键"))}},
  {__type=4,subtitle="显示报错信息",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("调式模式"))}},
  {__type=4,subtitle="允许加载代码",image=图标(""),status={Checked=Boolean.valueOf(this.getSharedData("允许加载代码"))}},

}


tab={

  ["内部浏览器查看回答"]=function()
    AlertDialog.Builder(this)
    .setTitle("不推荐开启此选项")
    .setMessage("开启后 回答 问题将会以知乎网页形式打开")
    .setCancelable(false)
    .setPositiveButton("我知道了",nil)
    .show()
  end,

  ["回答预加载(beta)"]=function()
    提示("此功能可能还有隐性bug,仅供体验，若影响体验请关闭")
  end,
  回答底栏设置滑动跟随=function()
    提示("开启后可能会有部分内容被底栏遮盖 若影响体验请关闭")
  end,
  夜间模式=function()
    提示("返回主页面生效")
    activity.setResult(1200,nil)
  end,
  夜间模式追随系统=function(self)
    self.夜间模式()
  end,
  关闭硬件加速=function(self)
    AlertDialog.Builder(this)
    .setTitle("小提示")
    .setMessage("开启后 可能会造成滑动卡顿 请酌情开启")
    .setCancelable(false)
    .setPositiveButton("我知道了",nil)
    .show()
  end,
  字体大小=function()
    activity.setResult(1200,nil)
  end,
  全屏模式=function()
    提示("为了更好的浏览体验 推荐重启App")
  end,
  热榜关闭图片=function()
    提示("设置成功 刷新热榜生效")
  end,
  热榜关闭热度=function()
    提示("设置成功 重刷新热榜生效")
  end,
  开启想法=function()
    提示("下次启动软件生效")
  end,
  修改主页排序=function()
    if not(getLogin()) then
      return 提示("请登录后使用本功能")
    end
    activity.newActivity("xgtj")
  end,
  设置默认主页=function()
    starthome={"推荐","想法","热榜","关注"}
    starthometab={["推荐"]=1,["想法"]=2,["热榜"]=3,["关注"]=4}
    --每次进入主页都检查starthome是否存在 所以一般情况下都存在
    starnum=starthometab[this.getSharedData("starthome")]
    tipalert=AlertDialog.Builder(this)
    .setTitle("请选择默认主页")
    .setSingleChoiceItems({"推荐","想法","热榜","关注"}, starnum-1,{onClick=function(v,p)
        starnum=p+1
    end})
    .setPositiveButton("确定", nil)
    .setNegativeButton("取消",nil)
    .show();
    tipalert.getButton(tipalert.BUTTON_POSITIVE).onClick=function()
      if starnum==nil then
        starnum=1
      end
      local starthome=starthome[starnum]
      if starthome=="想法" and this.getSharedData("开启想法")=="false" then
        提示("由于已关闭想法功能 所以无法选择想法")
       else
        this.setSharedData("starthome",starthome)
        starnum=nil
        提示("下次启动App生效")
      end
      tipalert.dismiss()
    end

  end,

  禁用大部分缓存=function()
    if this.getSharedData("禁用缓存")=="false" then
      clear()
    end
    提示("开启本并非完全禁用 只可禁用60％左右的缓存")
  end,
  自动清理缓存=function()
    提示("下次打开软件时生效")
  end,
  清理软件缓存=function()
    clear()
  end,

  关于=function()
    activity.newActivity("about")
  end,

  手动填写token=function()
    local example_data='{"uid":"xx","user_id":xz,"old_id":xx,"token_type":"xx","access_token":"xx","refresh_token":"xx","expires_in":xx,"cookie":{"q_c0":"xx","z_c0":"xx"},"unlock_ticket":null,"lock_in":null,"verification":null,"expires_at":xx}'
    local editDialog=AlertDialog.Builder(this)
    .setTitle("填写token")
    .setView(loadlayout({
      LinearLayout;
      layout_height="fill";
      layout_width="fill";
      orientation="vertical";
      {
        TextView;
        TextIsSelectable=true;
        layout_marginTop="10dp";
        layout_marginLeft="10dp",
        layout_marginRight="10dp",
        Text='请在下方输入你账号的数据 获取方式 使用抓包软件(例如HttpCanary) 安装https证书后 尝试抓取https://www.baidu.com 查看是否抓取成功 成功后退出知乎登录 抓取数据 登录成功后停止抓取数据 搜索 account/prod/sign_in 找到响应内容复制粘贴在这里 \n示例数据结构 注意 实际数据可能有出入\n'..example_data..'\n提示:请勿随意填写 填写错误可能会导致无法使用本软件 如填写无法使用请点击还原\n长按可复制内容';
        Typeface=字体("product-Medium");
      },
      {
        EditText;
        layout_width="match";
        layout_height="match";
        layout_marginTop="5dp";
        layout_marginLeft="10dp",
        layout_marginRight="10dp",
        id="edit";
        Typeface=字体("product");
      }
    }))
    .setPositiveButton("确定", nil)
    .setNeutralButton("还原",{onClick=function()
        local oridata=this.getSharedData("usersign")
        local oridata1=this.getSharedData("signdata")
        if oridata==nil then
          提示"你似乎还没有手动设置token"
         else
          this.setSharedData("signdata",oridata)
          this.setSharedData("userdata",oridata1)
          提示("还原成功")
        end
    end})
    .setNegativeButton("取消", nil)
    .create()

    local istrue=this.getSharedData("signdata")
    local 状态
    if istrue then
      状态="存在"
     else
      状态="不存在"
    end
    AlertDialog.Builder(this)
    .setTitle("提示")
    .setMessage("当登录时软件默认会自动获取并存储token 如果没有 你也可以手动填写 如果存在 就不推荐手动填写 可能会造成访问报错\n现阶段 软件还不会使用token 所以即使状态为不存在 也可以暂不填写".."\n".."当前状态："..状态)
    .setPositiveButton("我知道了",{onClick=function()
        editDialog.show()
        editDialog.getButton(editDialog.BUTTON_POSITIVE).onClick=function()
          local _check
          pcall(function()
            _check=luajson.decode(edit.Text)
            if _check.access_token then
              _check=_check.access_token
            end
          end)
          if _check then
            local myurl= 'https://www.zhihu.com/api/v4/me'
            local head = {
              ["authorization"] = _check
            }

            zHttp.get(myurl,head,function(code,content)

              if code==200 then--判断网站状态
                local oridata=this.getShatedData("signdata")
                this.setSharedData("usersign",oridata)
                this.setSharedData("signdata",edit.Text)
                提示("保存成功")
                editDialog.dismiss()
               else
                提示("获取个人信息失败 请检查输入内容是否正确")
              end
            end)
           else
            提示("获取access_token失败 请检查输入内容是否正确")
          end
        end
    end})
    .setNegativeButton("取消", nil)
    .show()
  end,

  ["管理/android/data存储"]=function()

    if this.getSharedData("data提示0.01")~="true" then
      AlertDialog.Builder(this)
      .setTitle("建议将Hydrogen的/android/data添加到文件管理器中")
      .setMessage("以下以MT管理器2.0举例".."\n".."点击MT管理器2.0右上角进入菜单 点击菜单内右上角三个点 点击添加本地存储 之后 点击右上角 进入菜单 往下找到Hydrogen 点击 进入后点击最下方的允许访问 之后 添加就成功了")
      .setCancelable(false)
      .setPositiveButton("我知道了",{onClick=function() this.setSharedData("data提示0.01","true") end})
      .show()
      return
    end

    import "android.content.Intent"
    import "android.net.Uri"
    import "java.net.URLDecoder"
    import "java.io.File"
    import "android.provider.DocumentsContract"
    import "android.content.ComponentName"

    import "android.content.pm.PackageManager"
    intent = Intent(Intent.ACTION_GET_CONTENT)
    intent.setType("*/*");
    intent.addCategory(Intent.CATEGORY_OPENABLE)
    info = this.getPackageManager().resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY);
    packageName = info.activityInfo.packageName;

    intent = Intent()
    intent.setType("*/*");
    uri=Uri.parse("content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fdata%2F"..activity.getPackageName().."%2Ffiles");
    intent.setData(uri);
    intent.setAction(Intent.ACTION_VIEW);
    componentName = ComponentName(packageName, "com.android.documentsui.files.FilesActivity");
    intent.setComponent(componentName);
    activity.startActivityForResult(intent,1);
    提示("已跳转"..tostring(activity.getExternalFilesDir(nil)).. "请自行管理")
  end,

  主题设置=function()
    newSubActivity("ThemePicker")
  end,


  显示报错信息=function()
    if this.getSharedData("调式模式")~="false" then
      this.setSharedData("调式模式","false")
      sta=1
    end
    if sta==1 then
      sta=0
      debugtip=AlertDialog.Builder(this)
      .setTitle("是否要开启?")
      .setMessage("开启后会提示一些错误信息 在一定程度上会影响阅读")
      .setCancelable(false)
      .setPositiveButton("开启",{onClick=function()
          this.setSharedData("调式模式","true") 提示("成功！重启App生效")
      end})
      .setNeutralButton("取消",{onClick=function() this.setSharedData("调式模式","false") data[#data-1].status["Checked"]=false adp.notifyDataSetChanged() end})
      .show()
     else
      this.setSharedData("调式模式","false")
      提示("成功！重启App生效")
    end
  end,

  允许加载代码=function()
    提示("开启后 将在右上角的功能中增加一个可以执行代码的选项")
  end
}


波纹({fh},"圆主题")

about_item={
  {--标题
    LinearLayout;

    layout_width="fill";
    layout_height="-2";
    {
      TextView;
      Focusable=true;
      layout_marginTop="12dp";
      layout_marginBottom="12dp";
      gravity="center_vertical";
      Typeface=字体("product-Bold");
      id="title";
      textSize="15sp";
      textColor=primaryc;
      layout_marginLeft="16dp";
    };
  };

  {--图片,标题,简介
    LinearLayout;
    gravity="center";
    layout_width="fill";
    layout_height="64dp";
    {
      ImageView;
      layout_height="25dp";
      id="image";
      layout_width="25dp";
      layout_marginLeft="15dp";
      ColorFilter=textc;
    };
    {
      LinearLayout;
      orientation="vertical";
      layout_height="fill";
      gravity="center_vertical";
      layout_weight="1";
      {
        TextView;
        id="subtitle";
        textSize="16sp";
        textColor=textc;
        Typeface=字体("product");
        layout_marginLeft="16dp";
      };
      {
        TextView;
        textColor=stextc;
        id="message";
        textSize="14sp";

        Typeface=字体("product");
        layout_marginLeft="16dp";
      };
    };
  };

  {--图片,标题
    LinearLayout;
    layout_width="fill";
    layout_height="64dp";
    gravity="center_vertical";
    {
      ImageView;
      layout_height="25dp";
      id="image";
      layout_width="25dp";
      layout_marginLeft="15dp";
      ColorFilter=textc;
    };
    {
      TextView;
      id="subtitle";
      Typeface=字体("product");
      textSize="16sp";
      textColor=textc;
      layout_marginLeft="16dp";
    };
  };



  {--图片,标题,switch
    LinearLayout;
    gravity="center_vertical";
    layout_width="fill";
    layout_height="64dp";
    {
      ImageView;
      layout_height="25dp";
      id="image";
      layout_width="25dp";
      layout_marginLeft="15dp";
      ColorFilter=textc;
    };
    {
      TextView;
      id="subtitle";
      Typeface=字体("product");
      textSize="16sp";
      textColor=textc;
      gravity="center_vertical";
      layout_weight="1";
      layout_height="-1";
      layout_marginLeft="16dp";
    };
    {
      MaterialSwitch;
      id="status";
      focusable=false;
      clickable=false;
      layout_marginRight="16dp";
    };

  };

  {--图片 标题 描述 选框
    LinearLayout;
    gravity="center_vertical";
    layout_width="fill";
    layout_height="64dp";
    {
      ImageView;
      layout_height="25dp";
      id="image";
      layout_width="25dp";
      layout_marginLeft="15dp";
      ColorFilter=textc;
    };
    {
      LinearLayout;
      orientation="vertical";
      layout_height="fill";
      gravity="center_vertical";
      {
        TextView;
        id="subtitle";
        textSize="16sp";
        textColor=textc;
        Typeface=字体("product");
        layout_marginLeft="16dp";
      };

    };
    {
      Slider;
      id="status";
      focusable=true;
      clickable=true;
      layout_marginRight="16dp";
    };

  };
};


if this.getSharedData("内部浏览器查看回答") == nil then
  this.setSharedData("内部浏览器查看回答","false")
end

adp=LuaMultiAdapter(this,data,about_item)
settings_list.setAdapter(adp)


settab={
  ["夜间模式"]="Setting_Night_Mode",
  ["夜间模式追随系统"]="Setting_Auto_Night_Mode",
  ["禁用大部分缓存"]="禁用缓存",
  ["暗色工具栏主题"]="theme_darkactionbar",
  ["显示报错信息"]="调式模式",
}--设置数据

settings_list.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(id,v,zero,one)
    if v.Tag.status ~= nil then

      if v.Tag.status.Checked then
        this.setSharedData(settab[tostring(v.Tag.subtitle.Text)] or v.Tag.subtitle.Text,"false")
        data[one].status["Checked"]=false
       else
        this.setSharedData(settab[tostring(v.Tag.subtitle.Text)] or v.Tag.subtitle.Text,"true")
        data[one].status["Checked"]=true
      end

    end
    (tab[tostring(v.Tag.subtitle.Text)] or function()end) (tab)
    adp.notifyDataSetChanged()--更新列表
end})