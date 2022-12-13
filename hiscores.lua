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
        progress[circuit]=prog
        local out='progress={'
        for i,p in ipairs(progress) do out=out..tostring(p)..',' end
        out=sub(out,1,#out-1) -- get rid of last comma
        out=out..'}'
        love.filesystem.write('PROG.RES',out)
    end
end

function load_progress()
    if not love.filesystem.exists('PROG.RES') then
        love.filesystem.write('PROG.RES','progress={0,0,0,0,0,0,0,0}')
    end
    loadstring(love.filesystem.read('PROG.RES'))()
end
