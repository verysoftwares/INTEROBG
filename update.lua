function player_update()
    local spd=0.2*4.8
    if press('right') then x=x+spd; if not rtutor then rtutor=true end end
    if press('left')  then x=x-spd; if not ltutor then ltutor=true end  end
    if press('down')  then y=y+spd; if not dtutor then dtutor=true end  end
    if press('up')    then y=y-spd; if not ututor then ututor=true end  end
    if x+1>320-3 then x=320-3-1 end; if x+1<0 then x=-1 end
    if y+1+1>200-3 then y=200-3-2 end; if y+1+1<0 then y=-2 end
    
    if press('pagedown') or (press('z') and not tapz) then tmult=tmult*0.991; if stage~=25 and tmult<1 then red_check=false end; if not pgshow then pgshow=true end; if not pgdtutor then pgdtutor=true end end
    if not press('z') then tapz=false end
    if press('pageup') or press('x') then tmult=tmult*(1/0.991); if not pgshow then pgshow=true end; if not pgututor then pgututor=true end end
    
    if (pgshow or (rtutor and ltutor and dtutor and ututor)) and not ftutor then
        if stage==1 and (rtutor and ltutor and dtutor and ututor) then
        ftutor=true
        timer=5*60
        pend_stage=stage+1
        stage=27
        skip_msg='SKIP: movement tutorial complete?!'
        bullets={}
        spec={}
        spawn_t=t+tmult
        elseif stage>1 then ftutor=true end
    end
    if stage==13 and all_grazed() then
        timer=5*60
        pend_stage=stage+1
        stage=27
        skip_msg='SKIP: all bullets grazed?!'
        bullets={}
        spec={}
        spawn_t=t+tmult
    end
end

function stage_update()
    -- bullet spawning logic
    -- get function stage1..stage24 and execute it
    local stageid=fmt('stage%d',stage)
    if _G[stageid] then _G[stageid]() end

    if stage~=1 and stage~=13 and stage~=17 then bullet_update() end

    timer_update()
end

function timer_update()
    if stage<=maxstages() then
        timer=timer-1
        if timer<=0 then
            timer=15*60
            -- if last stage in circuit then go to victory screen
            -- if second last stage then go to boss announcement
            if stage%3==0 then stage=25
            elseif stage%3==2 then pend_stage=stage+1; stage=26; timer=5*60; 
            else stage=stage+1 end
            
            bullets={}

            -- persistent bullets (circuit 6)
            if stage~=25 then
            local old_pb=spec.pb
            if spec.pb then for i,b in ipairs(spec.pb) do
                ins(bullets,b)
            end end
            spec={}
            spec.pb=old_pb
            else
            spec={}
            end

            spawn_t=t+tmult
        end 
    end
    if stage==26 or stage==27 then
        timer=timer-1
        if timer<=0 then
            timer=15*60
            stage=pend_stage
            bullets={}

            local old_pb=spec.pb
            if spec.pb then for i,b in ipairs(spec.pb) do
                ins(bullets,b)
            end end
            spec={}
            spec.pb=old_pb

            spawn_t=t+tmult
        end 
    end
end

function bullet_update()
    for i=#bullets,1,-1 do
        local b=bullets[i]
        b.x=b.x+b.dx*(t-b.bt); b.y=b.y+b.dy*(t-b.bt)
        b.bt=t
        if b.x<-6-1 or b.y<-6-1 or b.x>=320+1 or b.y>=200+1 then
            rem(bullets,i)
        end
    end
end

function collision_update()
    -- dying and grazing
    for i,r in ipairs(bullets) do
    if not r.safe and AABB(r.x+1,r.y+1,4,4,x+1,y+1+1,3,3) then
        love.update=wait; wt=120; shown_score=score; labels={}; break
    end
    if AABB(r.x,r.y,6,6,x+3-15,y+3-15,30,30) then
        if not r.grazed and not r.safe then
        -- score isn't updated immediately:
        -- you have to wait for the score label to
        -- reach the score counter.
        ins(labels,{x=r.x,y=r.y,tonumber(fmt('%.3d',flr(100*tmult+0.5)))})
        r.grazed=true
        end
    end
    end
end

function score_update()
    -- moving score labels
    for i=#labels,1,-1 do
        local l=labels[i]
        l.x=l.x+(320-50-l.x)*0.1
        l.y=l.y+(200-8-4-l.y)*0.1
        if abs(320-50-l.x)<=1 and abs(200-8-4-l.y)<=1 then
            score=score+l[1]
            rem(labels,i)
        end
    end

    shown_score=shown_score+(score-shown_score)*0.1
    if shown_score>score-0.5 then shown_score=score end
end

function wait()
    dt=love.timer.getTime()
    wt=wt-1
    if wt==0 then
        save_hiscores()
        if stage==25 then save_progress() end
        love.update=menu_update
        love.draw=menu_draw
        bullets={}
        spawn_t=t
        spec={}
    end
end

function maxstages()
    if not maxstage then
    for i=1,24 do
        local stageid=fmt('stage%d',i)
        if _G[stageid] then maxstage=i
        else break end
    end
    end
    return maxstage
end