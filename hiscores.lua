function save_hiscores()
    lastscores[circuit]=score
    if score>hiscores[circuit] then 
        hiscores[circuit]=score
        local out='hiscores={'
        for i,h in ipairs(hiscores) do out=out..tostring(h)..',' end
        out=sub(out,1,#out-1)
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
