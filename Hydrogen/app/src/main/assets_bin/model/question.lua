local base_question={
  nextUrl=nil,
  is_end=false,
  mdata={},
  data={}
}


function base_question:new(id)
  local child=table.clone(self)
  child.id=id
  return child
end

function base_question:getTag(callback)
  zHttp.get( "https://api.zhihu.com/questions/"..self.id.."/topics?limit=20&platform=android",head,function(code,body)

    if code==200 then
      for k,v in pairs(luajson.decode(body).data) do
        callback(v.name,v.url)
      end
    end

  end)
  return self
end

function base_question:clear()
  self.nextUrl=nil
  self.is_end=false
  self.data={}
  self.mdata={}
  return self
end


function base_question:setSortBy(tab)
  self.sortby=tab
  return self
end

function base_question:setresultfunc(tab)
  self.resultfunc=tab
  return self
end

function base_question:getData(callback)
  zHttp.get("https://api.zhihu.com/questions/"..self.id.."?include=read_count,answer_count,comment_count,follower_count,excerpt",apphead
  ,function(code,content)
    if code==200 then
      local data=luajson.decode(content)
      callback(data)
    end
  end)
  return self

end

function base_question:next(callback)

  if self.is_end~=true then

    zHttp.get(self.nextUrl or "https://api.zhihu.com/questions/"..self.id.."/feeds?include=badge%5B*%5D.topics,comment_count,excerpt,voteup_count,created_time,updated_time,upvoted_followees,voteup_count,media_detail&limit=20".."&order="..(self.sortby or "default"),head,function(code,body)

      if code==200 then
        self.nextUrl=luajson.decode(body).paging.next
        self.is_end=luajson.decode(body).paging.is_end
        for k,v in pairs(luajson.decode(body).data) do
          local v=v.target
          if self.mdata[v.id] then
           else
            self.mdata[v.id]=v --(概率需要(如果以后需要扩张功能的话))
            self.data[#self.data+1]=v
            self.data[#self.data].id=(self.data[#self.data].id)
            if self.resultfunc then self.resultfunc(v) end
          end
        end
        callback(true)
       else
        callback(false,body)
      end

    end)
   else
    callback(false,body)
  end
  return self
end

return base_question