function Building(_name, _cost, _type, _sprite = noone, _citizens = 0 ,_radius = 0, _damage = 0, _pollution = 0){
	return {
		name : _name,
		cost : _cost,
		type : _type, //Residential, Factory, Hospital
		sprite : _sprite,
		citizens : _citizens,
		radius : _radius,
		damage : _damage,
		pollution : _pollution,		
		event : -1
	}
}

global.EmptyBuilding = Building("Üres",0,"Empty")

global.Buildings = {
	"kicsi_tombhaz" : Building("Kicsi Tömbház", 10, "Residential", spr_Tomb1, 5),
	"kozepes_tombhaz" : Building("Közepes Tömbház", 10, "Residential", spr_Tomb2, 10),
	"nagy_tombhaz" : Building("Nagy Tömbház", 10, "Residential", spr_Tomb1, 15)
}