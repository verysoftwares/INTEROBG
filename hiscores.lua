function save_hiscores()
    lastscores[circuit]=score
    if score>hiscores[circuit] then 
        hiscores[circuit]=score
        local out='hiscores={'
        for i,h in ipairs(hiscores) do out=out..tostring(h)..',' end
        out=sub(out,1,#out-1) -- get rid of last comma
        out=out..'}'
        love.filesystem.write('HI.SCO',out)
    end
end

function load_hiscores()
    if not love.filesystem.exists('HI.SCO') then
        love.filesystem.write('HI.SCO','hiscores={0,0,0,0,0,0,0,0}')
    end
    loadstring(love.filesystem.read('HI.SCO'))()
    lastscores={0,0,0,0,0,0,0,0}
end

function save_progress()
    local prog=1
    if red_check then prog=2 end
    if prog>progress[circuit] then 
        local ac1=all_clear()
        local ar1=all_crushed()
        progress[circuit]=prog
        local ac2=all_clear()
        local ar2=all_crushed()

        if not ac1 and ac2 then love.update=victory_update; love.draw=victory_draw1 end
        if not ar1 and ar2 then love.update=victory_update; love.draw=victory_draw2 end

        local out='progress={'
        for i,p in ipairs(progress) do out=out..tostring(p)..',' end
        out=sub(out,1,#out-1) -- get rid of last comma
        out=out..'}'
        love.filesystem.write('PROG.RES',out)
    end
end

function all_clear()
    for i,p in ipairs(progress) do
        if p==0 then return false end
    end
    return true
end

function all_crushed()
    for i,p in ipairs(progress) do
        if p<2 then return false end
    end
    return true
end

function load_progress()
    if not love.filesystem.exists('PROG.RES') then
        love.filesystem.write('PROG.RES','progress={0,0,0,0,0,0,0,0}')
    end
    loadstring(love.filesystem.read('PROG.RES'))()
end

local victory_lines1={
    'congratulations!',
    'it\'s no easy feat to beat all 8 circuits.',
    '',
    'i hope you had fun, and continue',
    'to push for high scores.',
    '',
    'psst... if you crave more challenge,',
    'try to finish all circuits at 1.00x speed or higher!',
    '',
    '',
    '--Leonard Somero (verysoftwares)'
}

local victory_lines2={
    'big congratulations!',
    '>> you\'re truly a lunatic player <<',
    'for clearing all circuits at 1.00x speed or higher.',
    '',
    'i hope you had fun, and continue',
    'to push for high scores.',
    '',
    'psst... if you crave more challenge,',
    'try the registered version!',
    '',
    '',
    '--Leonard Somero (verysoftwares)'
}

function victory_draw1()
    checkerboard_draw()

    shareware_msg_draw('you\'ve won all circuits?!')

    register_msg_draw(victory_lines1)

    while love.timer.getTime()-dt<1/60 do
    end
end

function victory_draw2()
    checkerboard_draw()

    shareware_msg_draw('you\'ve crushed all circuits?!')

    register_msg_draw(victory_lines2)

    while love.timer.getTime()-dt<1/60 do
    end
end

function victory_update()
    dt=love.timer.getTime()

    t=t+1
end
