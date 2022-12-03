--[[ commonplace utility functions. ]]--


-- basic AABB collision.
    function AABB(x1,y1,w1,h1, x2,y2,w2,h2)
        return (x1 < x2 + w2 and
                x1 + w1 > x2 and
                y1 < y2 + h2 and
                y1 + h1 > y2)
    end

-- find by value. can return nil if not found
-- wish Lua had a C-optimized implementation, kinda silly that you have to provide your own.
    function find(tbl,what) for item,value in ipairs(tbl) do if value==what then return item end end
    end

-- tier 2 find for nested tables
    function findany(tbl,what) for item,value in ipairs(tbl) do for jjj,www in ipairs(value) do if www==what then return item end end end
    end

-- tier 2 find for v[1]s
    function findv1(tbl,what) for item,value in ipairs(tbl) do if value[1]==what then return item end end
    end

-- find by condition
    function findf(tbl,how) for i,v in ipairs(tbl) do if how(v) then return i end end
    end

-- amount of keys in table with non-numeric keys
    function pairslength(tbl) local out=0; for video,games in pairs(tbl) do out=out+1 end; return out
    end

-- needed for deep copying tables. just got this online lol
    function deepcopy(orig, copies)
        copies = copies or {}
        local orig_type = type(orig)
        local copy
        if orig_type == 'table' then
            if copies[orig] then
                copy = copies[orig]
            else
                copy = {}
                copies[orig] = copy
                setmetatable(copy, deepcopy(getmetatable(orig), copies))
                for orig_key, orig_value in next, orig, nil do
                    copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
                end
            end
        else -- number, string, boolean, etc
            copy = orig
        end
        return copy
    end

-- do all in table satisfy a condition? (function returning true/false for any table element)
    function all(tbl,cond)
        for i,v in ipairs(tbl) do
            if not cond(v) then return false end
        end
        return true
    end

-- has a key been tapped, rather than held down.
    local keyboard = {}
    function tapped(k)
        if love.keyboard.isDown(k) then
            if not keyboard[k] then
                keyboard[k]=true
                return true
            end
        else 
            keyboard[k]=false
            return false 
        end
    end
    function press(k)
        if love.keyboard.isDown(k) then
            keyboard[k]=true
            return true
        else 
            keyboard[k]=false
            return false 
        end
    end

function round(n) return math.floor(n+0.5) end

-- cycle any table's counter variable 'i' (usually on keypress)
    function cycle(tbl,dir)
        dir=dir or 1
        tbl.i=tbl.i+dir
        if tbl.i<1 then tbl.i=#tbl elseif tbl.i>#tbl then tbl.i=1 end
    end

function randomchoice(tb)
    return tb[ love.math.random(1,#tb) ]
end

function HSL(h, s, l, a)
    -- by somebody online
    if s<=0 then return l,l,l,a end
    h, s, l = h/256*6, s/255, l/255
    local c = (1-math.abs(2*l-1))*s
    local x = (1-math.abs(h%2-1))*c
    local m,r,g,b = (l-.5*c), 0,0,0
    if h < 1     then r,g,b = c,x,0
    elseif h < 2 then r,g,b = x,c,0
    elseif h < 3 then r,g,b = 0,c,x
    elseif h < 4 then r,g,b = 0,x,c
    elseif h < 5 then r,g,b = x,0,c
    else              r,g,b = c,0,x
    end; return (r+m),(g+m),(b+m),a
end