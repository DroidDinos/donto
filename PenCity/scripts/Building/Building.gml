function Building(_name, _cost, _type, _sprite = noone, _radius = 0, _damage = 0, _pollution = 0){
	return {
		name : _name,
		cost : _cost,
		type : _type, //Residential, Factory, Hospital
		sprite : _sprite,
		radius : _radius,
		damage : _damage,
		pollution : _pollution,		
		event : -1
	}
}

global.EmptyBuilding = Building("Üres",0,"Empty")

global.Buildings = {
	"kicsi_tombhaz" : Building("Kicsi Tömbház", 10, "Residential", spr_Tomb1),
	"kozep_tombhaz" : Building("Kicsi Tömbház", 10, "Residential", spr_Tomb2)
}