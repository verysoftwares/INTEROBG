font=lg.getFont()

function bg_draw()
    bg(0.1*255,0.1*255,0.1*255)
    fg(0.2*255,0.2*255,0.2*255)
    rect('fill',0,70,320,60)
    fg(0.3*255,0.3*255,0.3*255)
    rect('fill',0,70+20,320,20)
end

function bullet_draw(bl)
    local r,g,b=0.4,0.8,0.4
    
    if bl==spec.homer then r,g,b=0.8,0.8,0.4 end
    if bl.grazed then r,g,b=0.4,0.4,0.8 end
    if not bl.safe and love.update~=title_update and AABB(bl.x+1,bl.y+1,4,4,x+1,y+1+1,3,3) then r,g,b=0.8,0.8,0.8 end
    if bl.safe then r,g,b=0.8,0.4,0.4 end

    -- bullet body
    fg(r*255,g*255,b*255)
    rect('fill',bl.x,bl.y,6,6)
    -- bullet edge
    fg((r-0.2)*255,(g-0.2)*255,(b-0.2)*255)
    line(bl.x-1,bl.y,bl.x-1,bl.y+6)
    line(bl.x+6,bl.y,bl.x+6,bl.y+6)
    line(bl.x,bl.y-1,bl.x+6,bl.y-1)
    line(bl.x,bl.y+6,bl.x+6,bl.y+6)
    -- bullet shine
    fg((r+0.2)*255,(g+0.2)*255,(b+0.2)*255)
    line(bl.x+3,bl.y+1,bl.x+6,bl.y+1)
    line(bl.x+4,bl.y,bl.x+4,bl.y+3)
end

function player_draw()
    fg(0.8*255,0.4*255,0.4*255)

    fg(0.4*255,0.4*255,0.8*255)
    if love.update==wait then fg(0.8*255,0.8*255,0.8*255) end
    rect('fill',x+1,y+1+1,3,3)

    fg(0.8*255,0.4*255,0.4*255)
    if love.update==wait then fg(0.8*255,0.8*255,0.8*255) end
    line(x+2,y-2,x+2+5,y-2+9)
    line(x+2,y-2,x+2-5,y-2+9)
    line(x+2-5,y-2+9,x+2,y-2+7)
    line(x+2+5,y-2+9,x+2,y-2+7)

    -- grazebox
    fg(0.4*255,0.4*255,0.8*255)
    rect('line',x+3-15,y+3-15,30,30)
end

function overlay_draw()
    tutor_draw()

    if pgshow then
        fg(0.8*255,0.8*255,0.8*255)
        lg.print(fmt('Time is running at %.2fx speed',tmult),8,16)
    end

    header_draw()
end

function tutor_draw()
    if stage==27 then return end
    
    fg(0.8*255,0.8*255,0.8*255)
    if not pgshow then
    if not rtutor then lg.print('Right',x+6+3,y-2) end
    if not ltutor then lg.print('Left',x-font:getWidth('Left')-2,y-2) end
    if not ututor then lg.print('Up',x+3-font:getWidth('Up')/2,y-font:getHeight('Up')) end
    if not dtutor then lg.print('Down',x+3-font:getWidth('Down')/2,y+6+1) end
    end
    if ftutor and not pgdtutor and not pgututor then
        lg.print('Z',x+3-font:getWidth('Z')/2,y+6+1)
    end
    if pgdtutor and not pgututor then
        lg.print('X',x+3-font:getWidth('X')/2,y-font:getHeight('X'))
    end
end

function header_draw()
    fg(0.4*255,0.8*255,0.4*255)
    rect('fill',0,0,320,10)

    fg(0.1*255,0.1*255,0.1*255)
    local msg='this is the 15th verysoftwares game this year?! aRE YOU SERIOUS?!'
    if stage==2 then msg='bullet time in a bullet hell?!' end
    if stage==3 then msg='how\'s this one for size?!' end
    if stage==4 then msg='graze graze graze?!' end
    if stage==5 then msg='faster faster faster?!' end
    if stage==6 then msg='expect nothing?!' end
    if stage==7 then msg='double trouble?!' end
    if stage==8 then msg='who\'s afraid of circles?!' end
    if stage==9 then msg='yikes?!' end
    if stage==10 then msg='do you know streaming?!' end
    if stage==11 then msg='do you feel targeted?!' end
    if stage==12 then msg='that yellow bullet looks like it wants a hug?!' end
    if stage==13 then msg='is this the demoscene?!' end
    if stage==14 then msg='is this the title screen?!' end
    if stage==15 then msg='i always knew it would be the squares that killed me?!' end
    if stage==16 then msg='it takes a steady hand to draw a perfect circle?!' end
    if stage==17 then msg='bouncy bois aplenty?!' end
    if stage==18 then msg='i wonder if this attack is too difficult?!' end
    if stage==19 then msg='the attacks in this circuit reference 3BUTTERF.EXE?!' end
    if stage==20 then msg='this one\'s a simplified S3W5?!' end
    if stage==21 then msg='sorry, but this attack is actually impossible?!' end
    if stage==22 then msg='this trap is back with a vengeance?!' end
    if stage==23 then msg='remember the tutorial boss?!' end
    if stage==24 then msg='if you can beat this you\'re a lunatic?!' end
    if stage==25 then 
        if score>hiscores[circuit] then msg='congrats for a high score?! enjoy the fireworks & press Esc when ready?!'
        else msg='congrats?! now go for a high score?! press Esc when ready?!' end
    end
    if stage==26 then msg='BIG BAD INCOMING?!' end
    if stage==27 then msg=skip_msg end

    if stage>maxstages() and stage~=25 and stage~=26 and stage~=27 then 
        msg='you\'re not supposed to be here yet?! go back with Esc?!' 
    end

    lg.print(msg,320/2-font:getWidth(msg)/2+sin(t*0.004*8.8)*24,0)
end

function score_draw()
    fg(0.8*255,0.4*255,0.4*255)
    for i,l in ipairs(labels) do
        lg.print(fmt('%.3d',l[1]),l.x,l.y)
    end

    local msg=fmt('%.9d',flr(shown_score))
    for i=1,#msg do
    local ox=0
    if sub(msg,i,i)=='1' then ox=1 end
    lg.print(sub(msg,i,i),320-font:getWidth('000000000')-4+(i-1)*6+ox,200-8-4)
    end

    fg(0.8*255,0.8*255,0.8*255)
    local msg=fmt('%.2d:%.2d',timer/60,timer%60*(100/60))
    for i=1,#msg do
    local ox=0
    if sub(msg,i,i)=='1' or sub(msg,i,i)==':' then ox=1 end
    lg.print(sub(msg,i,i),320-font:getWidth('000000000')-font:getWidth('00000')-4+(i-1)*6+ox,200-8-4)
    end
end

function special_draw()
    if stage==19 then
        if spec.warn_t and t-spec.warn_t<20 then
            lg.line(x-cos(spec.warn_a)*120,y-sin(spec.warn_a)*120,x-cos(spec.warn_a)*120+cos(spec.warn_a)*(t-spec.warn_t)*24,y-sin(spec.warn_a)*120+sin(spec.warn_a)*(t-spec.warn_t)*24,12)
        end
    end
    if stage==26 then
        call_draw('BOSS')
    end
    if stage==27 then
        call_draw('SKIP')
    end
end

-- animated banner
function call_draw(msg)
    local tx=-11
    if msg=='SKIP' then tx=-10 end

    for i=0,24 do
    if i%2==0 then
        fg(0.4*255,0.8*255,0.4*255)
    else
        fg(0.4*255,0.8*255,0.4*255)
        rect('fill',-(t-spawn_t)+i*font:getWidth(msg),24+6,font:getWidth(msg),font:getHeight(msg))
        rect('fill',tx*font:getWidth(msg)+(t-spawn_t)+i*font:getWidth(msg),200-24-6-font:getHeight(msg),font:getWidth(msg),font:getHeight(msg))
        fg(0.1*255,0.1*255,0.1*255)
    end
    lg.print(msg,-(t-spawn_t)+i*font:getWidth(msg),24+6)
    lg.print(msg,tx*font:getWidth(msg)+(t-spawn_t)+i*font:getWidth(msg),200-24-6-font:getHeight(msg))
    end
end