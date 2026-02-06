function Building(_name,_cost,_type,_radius, _damage = 0, _pollution = 0){
	return {
		name : _name,
		cost : _cost,
		type : _type, //Residential, Factory, Hospital
		radius : _radius,
		damage : _damage,
		pollution : _pollution,		
		event : -1
	}
}

global.EmptyBuilding = Building("Empty",0,"Empty",0)
