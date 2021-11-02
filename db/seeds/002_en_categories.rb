require_relative '../seed_helpers/hierarchy_seeder.rb'
hierarchy = [
  {nba: "NBA",
  conferences:
    [{afc_east: "AFC East",
      teams: [{ afc_e1: "AFC E1" }, { afc_e2: "AFC E2" }, { afc_e3: "AFC E3" }]},
     {afc_north: "AFC North",
      teams: [{ afc_n1: "AFC N1" }, { afc_n2: "AFC N2" }]},
     {afc_south: "AFC South",
      teams: [{afc_s1: "AFC S1"}]}
    ]},
  {nfl:"NFL",
   conferences:
     [{east_division:"East Division",
       teams:[{ed_1: "ED 1"}, {ed_2: "ED 2"}, {ed_3: "ED 3"}]},
      {west_division:"West Division",
       teams:[{wd_1: "WD 1"}, {wd_2: "WD 2"}]},
      {north_division:"North Division", teams:[{"nd_1"=>"ND 1"}]},
      {south_division:"South Division", teams:[]}
     ]},
  {mlb:"MLB",
   conferences:
     [{al_east:"AL East", teams:[{al_e1: "AL E1"}, {al_e2: "AL E2"}]},
      {al_central:"AL Central", teams:[{al_c1: "AL C1"}]}]},
  {golf:"Golf",
   conferences:
     [{asun:"ASUN", teams:[{as_171: "AS 171"}]},
      {socon:"SoCon", teams:[{sc_1: "SC 1"}]}
     ]},
  {mlg:"MLG",
   conferences:
     [{cod_league:"COD league",
       teams:[{faze_clan: "Faze Clan"}, {navi: "NaVi"}]},
      {overwatch_league:"Overwatch league",
       teams:
         [{cloud_9: "Cloud 9"},
          {fnatic: "Fnatic"},
          {boston_uprising: "Boston Uprising"}]},
      {halo_league:"Halo league",
       teams:
         [{team_liquid: "Team Liquid"},
          {evil_geniuses: "Evil Geniuses"},
          {optic: "Optic"}]}]}
]

en_lang = Language.find_or_create_by!(key: 'en')
CategorySeeder.new(en_lang).seed_data(hierarchy)