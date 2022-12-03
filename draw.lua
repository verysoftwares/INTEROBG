function bullet_draw(bl)
    local r,g,b=0.4,0.8,0.4
    
    if bl.grazed then r,g,b=0.4,0.4,0.8 end
    if not bl.safe and AABB(bl.x+1,bl.y+1,4,4,x+1,y+1,4,4) then r,g,b=0.8,0.8,0.8 end
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
        lg.print(fmt('Time is running at %.2fx speed',tmult),8,16)
    end

    header_draw()
end

function tutor_draw()
    local fn=lg.getFont()
    fg(0.8*255,0.8*255,0.8*255)
    if not pgshow then
    if not rtutor then lg.print('Right',x+6+3,y-2) end
    if not ltutor then lg.print('Left',x-fn:getWidth('Left')-2,y-2) end
    if not ututor then lg.print('Up',x+3-fn:getWidth('Up')/2,y-fn:getHeight('Up')) end
    if not dtutor then lg.print('Down',x+3-fn:getWidth('Down')/2,y+6+1) end
    end
    if ftutor and not pgdtutor and not pgututor then
        lg.print('Z',x+3-fn:getWidth('Z')/2,y+6+1)
    end
    if pgdtutor and not pgututor then
        lg.print('X',x+3-fn:getWidth('X')/2,y-fn:getHeight('X'))
    end
end

function header_draw()
    local fn=lg.getFont()

    fg(0.4*255,0.8*255,0.4*255)
    rect('fill',0,0,320,10)

    fg(0.1*255,0.1*255,0.1*255)
    local msg='this is the 15th verysoftwares game this year?! aRE YOU SERIOUS?!'
    if stage==2 then msg='bullet time in a bullet hell?!' end
    if stage==3 then msg='how\'s this one for size?!' end
    if stage==25 then 
        if score>hiscores[circuit] then msg='congrats for a high score?! enjoy the fireworks & press Esc when ready?!'
        else msg='congrats?! now go for a high score?! press Esc when ready?!' end
    end
    if stage==4 then msg='graze graze graze?!' end
    if stage==5 then msg='faster faster faster?!' end
    if stage==6 then msg='expect nothing?!' end
    if stage==7 then msg='double trouble?!' end
    if stage==8 then msg='who\'s afraid of circles?!' end
    if stage==9 then msg='yikes?!' end
    if stage>maxstages() and stage~=25 and stage~=26 then msg='you\'re not supposed to be here yet?! go back with Esc?!' end
    if stage==26 then msg='BIG BAD INCOMING?!' end

    lg.print(msg,320/2-fn:getWidth(msg)/2+sin(t*0.004*8.8)*24,0)
end

function score_draw()
    local fn=lg.getFont()

    fg(0.8*255,0.4*255,0.4*255)
    for i,l in ipairs(labels) do
        lg.print(fmt('%.3d',l[1]),l.x,l.y)
    end

    lg.print(fmt('%.9d',flr(shown_score)),320-fn:getWidth(fmt('%.9d',flr(shown_score)))-4,200-8-4)

    fg(0.8*255,0.8*255,0.8*255)
    lg.print(fmt('%.2d:%.2d',timer/60,timer%60*(100/60)),320-fn:getWidth(fmt('%.9d',flr(shown_score)))-fn:getWidth(fmt('%.2d:%.2d',timer/60,timer%60*(100/60)))-4,200-8-4)
end

function bosscall_draw()
    local fn=lg.getFont()

    for i=0,24 do
    if i%2==0 then
        fg(0.4*255,0.8*255,0.4*255)
    else
        fg(0.4*255,0.8*255,0.4*255)
        rect('fill',-(t-sc_t)+i*fn:getWidth('BOSS'),24+6,fn:getWidth('BOSS'),fn:getHeight('BOSS'))
        rect('fill',-11*fn:getWidth('BOSS')+(t-sc_t)+i*fn:getWidth('BOSS'),200-24-6-fn:getHeight('BOSS'),fn:getWidth('BOSS'),fn:getHeight('BOSS'))
        fg(0.1*255,0.1*255,0.1*255)
    end
    lg.print('BOSS',-(t-sc_t)+i*fn:getWidth('BOSS'),24+6)
    lg.print('BOSS',-11*fn:getWidth('BOSS')+(t-sc_t)+i*fn:getWidth('BOSS'),200-24-6-fn:getHeight('BOSS'))
    end
end