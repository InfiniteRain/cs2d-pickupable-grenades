gren = {} -- Main table

-- Adding hooks
addhook('attack', 'gren.hook.attack')

gren.hook = { -- Hooked functions
	attack = function(id)
		if player(id, 'weapontype') == 50 then -- If player is holding knife, then...
			for k, v in pairs(projectilelist(1)) do -- Checking all the ground projectiles
				local ptype = projectile(v.id, v.player, 'type') -- Making shortcut for knowing the type of projectile
				if ptype == 51 or ptype == 52 or ptype == 53 or ptype == 54 then -- Checking if the projectile is grenade
					for _, ti in pairs(playerweapons(id)) do ---------
						if ti == ptype then return end		 --Checking if the player already has got the grenade, and if he has, then grenade won't be taken
					end										 ---------
					local x, y = projectile(v.id, v.player, 'x'), projectile(v.id, v.player, 'y') -- Making shortcut for knowing the projectile position
					local px, py = player(id, 'x'), player(id, 'y') -- Making shortcut for knowing the player position
					if px >= x - 16 and py >= y - 16 and px <= x + 16 and py <= y + 16 then -- If the player is near the projectile, then...
						parse('freeprojectile '.. v.id ..' '.. v.player) -- Vanish projectile
						parse('equip '.. id ..' '.. ptype) -- Equipping the grenade he took
						parse('setweapon '.. id ..' '.. ptype) -- Making player to hold the grenade
					end
				end
			end
		end
	end;
}