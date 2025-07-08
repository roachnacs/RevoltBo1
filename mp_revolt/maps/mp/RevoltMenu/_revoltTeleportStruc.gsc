#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\RevoltMenu\_revoltMenuFuncs;
#include maps\mp\gametypes\_clientids;
#include maps\mp\RevoltMenu\_revoltFuncs;

mapTeleports()
{
    if( getdvar("mapname") == "mp_array")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "tower", ::TeleportSpot, (2601.44, 307.3,696.975));
        self add_option("map teleports", "satellite dish", ::TeleportSpot, (-1153, 2640, 711));
        self add_option("map teleports", "back ladder", ::TeleportSpot, (-2112.11, 2118.26, 661.125));
        self add_option("map teleports", "control room", ::TeleportSpot, (356, 792, 536));
        self add_option("map teleports", "echo spot", ::TeleportSpot, (3384.93, 1893.78, 252.164));
        self add_option("map teleports", "lcsihz spot", ::TeleportSpot, (-2279, 1217, 424));
    }
    else if( getdvar("mapname") == "mp_cracked")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (-399.487, -924.336, 103.98));
        self add_option("map teleports", "stairs ledge", ::TeleportSpot, (-1350.1, -921.116, 80.1332));
        self add_option("map teleports", "sandbag ledge", ::TeleportSpot, (-2068.36, 225.884, -19.875));
        self add_option("map teleports", "roach lunge spot", ::TeleportSpot, (-274, -1036, 113));
        self add_option("map teleports", "out of map spot", ::TeleportSpot, (-547.151, 2783.21, 1183.20));
    }
    else if( getdvar("mapname") == "mp_crisis")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (-2346.45, 42.1061, 338.907));
        self add_option("map teleports", "bridge", ::TeleportSpot, (-572.372, 1143.91, 278.005));
        self add_option("map teleports", "sandbag ledge", ::TeleportSpot, (416.853, 957.162, 332.128));
        self add_option("map teleports", "back ladder", ::TeleportSpot, (1829.18, 1713.3, 262.044));
        self add_option("map teleports", "roof in cliff", ::TeleportSpot, (-120.286, 1506.05, 262.186));
        self add_option("map teleports", "out of map spot", ::TeleportSpot, (-509.417, -1646.02, 144.125));
    }
    else if( getdvar("mapname") == "mp_firingrange")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (578.162, 1107.8, 228.083));
        self add_option("map teleports", "high doors", ::TeleportSpot, (-262.363, 1175.59, 189.971));
        self add_option("map teleports", "knife lunge Teleport", ::TeleportSpot, (-1247.12, 1382.38, 80.2608));
        self add_option("map teleports", "tower window (crouch)", ::TeleportSpot, (377.786, 1073.85, 233.999));
        self add_option("map teleports", "back ladder", ::TeleportSpot, (1475.09, 1296.17, 81.125));
        self add_option("map teleports", "out of map spot", ::TeleportSpot, (-1600.9, 658.461, 193.017));
        self add_option("map teleports", "out of map spot 2", ::TeleportSpot, (-1543.85, -2499.81, 354.749));
    }
    else if( getdvar("mapname") == "mp_duga")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (-730.218, -3369.63, 157.522));
        self add_option("map teleports", "ladder run up", ::TeleportSpot, (-454.454, -3213.38, 136.125));
        self add_option("map teleports", "back ladder", ::TeleportSpot, (-2387.72, -2762.28, 137.016));
        self add_option("map teleports", "back truck", ::TeleportSpot, (-847.433, -4547.62, 157.125));
        self add_option("map teleports", "phillip window", ::TeleportSpot, (-1603.03, -3273.32, 136.125));
        self add_option("map teleports", "hollow window", ::TeleportSpot, (-1492.89, -2305.69, 136.125));
        self add_option("map teleports", "top bunker", ::TeleportSpot, (-1407.15, -1330.12, 264.125));
    }
    else if( getdvar("mapname") == "mp_hanoi")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "ladder spot", ::TeleportSpot, (465.141, -1896.19, 64.125));
        self add_option("map teleports", "roach window", ::TeleportSpot, (12.2965, -1684.91, 97.4029));
        self add_option("map teleports", "bus", ::TeleportSpot, (43.8066, 706.697, 87.625));
        self add_option("map teleports", "wall", ::TeleportSpot, (515.03, 1009.09, 43.125));
        self add_option("map teleports", "back ledge", ::TeleportSpot, (526.965, 1313.22, 116.125));
        self add_option("map teleports", "hearts spot", ::TeleportSpot, (-443.106, -2924.56, 364.372));
        self add_option("map teleports", "novas spot", ::TeleportSpot, (900.273, 128.359, 98.1954));
        self add_option("map teleports", "cart bounce", ::TeleportSpot, (-1694.04, -2652.28, 104.585));
    }
    else if( getdvar("mapname") == "mp_cairo")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (1117.25, 266.186, 167.372));
        self add_option("map teleports", "bounce", ::TeleportSpot, (-1846.41, -438.616, 152.125));
        self add_option("map teleports", "pikas balcony", ::TeleportSpot, (-271.315, -1217.125, 172.125));
        self add_option("map teleports", "geen delayed lunge", ::TeleportSpot, (404.188, -824.641, 136.125));
        self add_option("map teleports", "out of map spot", ::TeleportSpot, (690.937, -1724.94, 277.879));
    }
    else if( getdvar("mapname") == "mp_havoc")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (1521.91, -935.472, 486.834));
        self add_option("map teleports", "mid ladder", ::TeleportSpot, (2168.64, 178.6, 268.125));
        self add_option("map teleports", "mid ladder 2", ::TeleportSpot, (400.621, -1185.19, 296.125));
        self add_option("map teleports", "back ladder", ::TeleportSpot, (2193.31, -2438.18, 277.125));
        self add_option("map teleports", "temple", ::TeleportSpot, (1295.12, 1740.56, 286.125));
        self add_option("map teleports", "pikas spot", ::TeleportSpot, (41.6131, 1063.19, 605.125));
        self add_option("map teleports", "roach wall breach", ::TeleportSpot, (885.11, -1216.5, 125.891));
    }
    else if( getdvar("mapname") == "mp_cosmodrome")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot side a", ::TeleportSpot, (2030.6, -313.56, 25.8942));
        self add_option("map teleports", "main trickshot side b", ::TeleportSpot, (2030.6, 1050.2, 25.8942));
        self add_option("map teleports", "mid ladder", ::TeleportSpot, (-710.683, -161.641, 47.125));
        self add_option("map teleports", "mid ladder 2", ::TeleportSpot, (-787.532, 857.641, 56.125));
        self add_option("map teleports", "geens sui", ::TeleportSpot, (1865.58, 696.215, -9.875));
        self add_option("map teleports", "pikas window", ::TeleportSpot, (-552.359, -1922.36, -1.80461));
    }
    else if( getdvar("mapname") == "mp_nuked")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "glitched bus", ::TeleportSpot, (229.952, 243.159, 88.3563));
        self add_option("map teleports", "front yellow", ::TeleportSpot, (513.135, 156.066, 77.9509));
        self add_option("map teleports", "front blue", ::TeleportSpot, (-455.444, 348.863, 75.125));
        self add_option("map teleports", "back yellow", ::TeleportSpot, (1353.4, 240.404, 114.871));
        self add_option("map teleports", "back blue", ::TeleportSpot, (-1191.33, 774.053, 114.893));
    }
    else if( getdvar("mapname") == "mp_radiation")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (-919.343, 25.0547, 352.125));
        self add_option("map teleports", "mid map 1", ::TeleportSpot, (127.485, -380.02, 295.125));
        self add_option("map teleports", "mid map 2", ::TeleportSpot, (-124.577, 391.777, 295.125));
        self add_option("map teleports", "conveyor belt", ::TeleportSpot, (2222.52, 1032.88, 309.125));
        self add_option("map teleports", "inside ladder", ::TeleportSpot, (2244.36, 166.813, 309.125));
        self add_option("map teleports", "back ladder", ::TeleportSpot, (-1238.67, -1866.181, 181.125));
        self add_option("map teleports", "roach spot", ::TeleportSpot, (-586.797, -1727.51, 163.965));
        self add_option("map teleports", "inside beam", ::TeleportSpot, (65.1605, 1124.04, 268.125));
    }
    else if( getdvar("mapname") == "mp_mountain")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (2026.96, -377.801, 478.793));
        self add_option("map teleports", "spawn sui 1", ::TeleportSpot, (2317.27, 1472.61, 355.698));
        self add_option("map teleports", "spawn sui 2", ::TeleportSpot, (2403.97, -2885.94, 387.473));
        self add_option("map teleports", "spawn sui 3", ::TeleportSpot, (4028.66, 1451.83, 318.125));
        self add_option("map teleports", "spawn sui 4", ::TeleportSpot, (3722.08, -2373.65, 433.625));
        self add_option("map teleports", "knife lunge spot", ::TeleportSpot, (1683.15, -1700.73, 252.472));
        self add_option("map teleports", "roach lunge spot", ::TeleportSpot, (3892.69, -137.641, 374.125));
        self add_option("map teleports", "ladder elevator", ::TeleportSpot, (1889.32, -279.663, 222.517));
        self add_option("map teleports", "pikas window", ::TeleportSpot, (2160.95, -1180.23, 474));
        self add_option("map teleports", "pikas ladder", ::TeleportSpot, (3534.86, -2614.16, 619.125));
    }
    else if( getdvar("mapname") == "mp_villa")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "roach window", ::TeleportSpot, (4370.25, 2532.79, 376.125));
        self add_option("map teleports", "lcsihz window", ::TeleportSpot, (2904.93, 105.427, 456.125));
        self add_option("map teleports", "pika window", ::TeleportSpot, (2767, 1067.74, 376.125));
        self add_option("map teleports", "main balcony", ::TeleportSpot, (4144.63, 510.959, 456.125));
        self add_option("map teleports", "alt balcony", ::TeleportSpot, (4655.86, -141.946, 491.487));
        self add_option("map teleports", "glitched archway", ::TeleportSpot, (1391.6, 1970.2, 434.62));
    }
    else if( getdvar("mapname") == "mp_russianbase")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (-1246.2, -93.8406, 487.284));
        self add_option("map teleports", "main ladder", ::TeleportSpot, (-1471.34, 388.245, 454.125));
        self add_option("map teleports", "silo ladder", ::TeleportSpot, (1891.12, -108.359, 192.125));
        self add_option("map teleports", "spawn window", ::TeleportSpot, (1258.16, 1042.34, 160.125));
    }
    else if( getdvar("mapname") == "mp_berlinwall2")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "window 1", ::TeleportSpot, (1750.51, -2052.56, 236.125));
        self add_option("map teleports", "window 2", ::TeleportSpot, (50.1249, -2027.21, 207.125));
        self add_option("map teleports", "window 3", ::TeleportSpot, (800.572, -1307.6, 218.125));
        self add_option("map teleports", "window 4", ::TeleportSpot, (-1601.13, 916.67, 178.125));
        self add_option("map teleports", "novas window", ::TeleportSpot, (-294.363, 386.355, 187.125));
        self add_option("map teleports", "sui window", ::TeleportSpot, (-360.646, 220.985, 187.125));
        self add_option("map teleports", "hole in the wall", ::TeleportSpot, (1095.13, -1113.36, 218.125));
        self add_option("map teleports", "ladder 1", ::TeleportSpot, (895.412, -1417.6, 217.625));
        self add_option("map teleports", "ladder 2", ::TeleportSpot, (-692.144, -1426.51, 180.425));
        self add_option("map teleports", "ladder 3", ::TeleportSpot, (-1383.7, 1270.55, 182.125));
        self add_option("map teleports", "ladder 4", ::TeleportSpot, (-392.139, 606.05, 180.425));
        self add_option("map teleports", "tunnel light", ::TeleportSpot, (511.151, 1262.95, 237.522));
        self add_option("map teleports", "wall spot", ::TeleportSpot, (2321.87, 83.8496, 265.06));
        self add_option("map teleports", "guard tower", ::TeleportSpot, (-108.553, -793.036, 358.125));
        self add_option("map teleports", "building wall breach", ::TeleportSpot, (-874.772, 144.129, 297.875));
    }
    else if( getdvar("mapname") == "mp_discovery")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (-2092.58, -137.944, 199.984));
        self add_option("map teleports", "main ladder", ::TeleportSpot, (-1237.89, -572.892, 56.125));
        self add_option("map teleports", "back ladder", ::TeleportSpot, (-275.461, -2656.62, 140.358));
        self add_option("map teleports", "echo ladder", ::TeleportSpot, (-355.429, 1044.97, 180.125));
        self add_option("map teleports", "middle bridge", ::TeleportSpot, (-641, 215.914, 103.016));
        self add_option("map teleports", "roach window", ::TeleportSpot, (-1540.08, -499.702, 56.125));
        self add_option("map teleports", "out of map back drop", ::TeleportSpot, (-1371.63, 2713.08, 415.799));
    }
    else if( getdvar("mapname") == "mp_kowloon")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main ladder", ::TeleportSpot, (343.154, 220.556, 309.125));
        self add_option("map teleports", "zipline 1", ::TeleportSpot, (23.6409, 617.484, 196.125));
        self add_option("map teleports", "zipline 2", ::TeleportSpot, (916.805, 938.996, 121.125));
        self add_option("map teleports", "back ladder", ::TeleportSpot, (-1638.45, -899.565, -37.875));
        self add_option("map teleports", "fortune suicide", ::TeleportSpot, (-1703.46, 992.488, -151.875));
        self add_option("map teleports", "pika repeater", ::TeleportSpot, (-294.568, -810.625, 59.4531));
    }
    else if( getdvar("mapname") == "mp_stadium")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (-46.0432, 1852.46, 163.955));
        self add_option("map teleports", "main ladder", ::TeleportSpot, (-929.907, 128.853, 208.125));
        self add_option("map teleports", "catwalk", ::TeleportSpot, (601.813, 1103.55, 189.909));
        self add_option("map teleports", "office balcony", ::TeleportSpot, (1334.88, 2056.56, 192.027));
        self add_option("map teleports", "hockey rink", ::TeleportSpot, (-1891.53, 1925.9, 237.94));
        self add_option("map teleports", "echos glitch", ::TeleportSpot, (345.132, 2120.61, 196.325));
    }
    else if( getdvar("mapname") == "mp_gridlock")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "left ladder", ::TeleportSpot, (-905.59, -266.462, 245.266));
        self add_option("map teleports", "right ladder", ::TeleportSpot, (-970.571, 462.086, 245.125));
        self add_option("map teleports", "billboard ladder", ::TeleportSpot, (-329.86, -1292.44, 67.125));
        self add_option("map teleports", "motel stairs", ::TeleportSpot, (-1608.62, 1456.63, 169.154));
        self add_option("map teleports", "motel balcony", ::TeleportSpot, (-1776.22, 830.166, 130.125));
        self add_option("map teleports", "front bridge", ::TeleportSpot, (273.076, 560.482, 130.29));
        self add_option("map teleports", "back bridge", ::TeleportSpot, (-5.00724, -296.178, 142.759));
        self add_option("map teleports", "close catwalk", ::TeleportSpot, (945.654, 0.612097, 301.084));
        self add_option("map teleports", "far catwalk", ::TeleportSpot, (-867.391, 52.2598, 240.125));
        self add_option("map teleports", "window 1", ::TeleportSpot, (1841.9, -1247.24, 79.125));
        self add_option("map teleports", "window 2", ::TeleportSpot, (1822.21, -892.19, 79.125));
        self add_option("map teleports", "window 3", ::TeleportSpot, (2171.64, 1316.35, 96.125));
        self add_option("map teleports", "window 4", ::TeleportSpot, (2134.94, 1545.6, 96.125));
        self add_option("map teleports", "window 5", ::TeleportSpot, (-1526.39, 1268.94, 130.125));
    }
    else if( getdvar("mapname") == "mp_hotel")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "suicide spot 1", ::TeleportSpot, (-279.562, 755.969, 101.894));
        self add_option("map teleports", "suicide spot 2", ::TeleportSpot, (6580.8, 179.498, 101.976));
        self add_option("map teleports", "suicide spot 3", ::TeleportSpot, (1400.82, -2214.11, -45.5907));
        self add_option("map teleports", "window 1", ::TeleportSpot, (4109.57, -437.493, 184.125));
        self add_option("map teleports", "window 2", ::TeleportSpot, (1631.99, -316.669, 160.125));
        self add_option("map teleports", "hollow spot", ::TeleportSpot, (309.426, -1924.3, 104.125));
        self add_option("map teleports", "hollow alt spot", ::TeleportSpot, (5137.46, 531.149, 104.125));
    }
    else if( getdvar("mapname") == "mp_outskirts")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (1502.86, 685.874, 414.006));
        self add_option("map teleports", "ladder 1", ::TeleportSpot, (-363.279, -139.32, 198.12));
        self add_option("map teleports", "ladder 2", ::TeleportSpot, (207.641, -976.037, 152.125));
        self add_option("map teleports", "nova window", ::TeleportSpot, (-19.3893, -1229.07, 189.459));
    }
    else if( getdvar("mapname") == "mp_zoo")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (1024.53, 148.779, 142.125));
        self add_option("map teleports", "ladder 1", ::TeleportSpot, (1266.04, 627.337, 146.125));
        self add_option("map teleports", "ladder 2", ::TeleportSpot, (-1255.38, -849.195, -5.875));
        self add_option("map teleports", "window 1", ::TeleportSpot, (30.4166, 12.3945, 144.125));
        self add_option("map teleports", "window 2", ::TeleportSpot, (442.93, 1394.8, 90.125));
        self add_option("map teleports", "window 3", ::TeleportSpot, (408.74, 1748.98, 88.125));
        self add_option("map teleports", "cave glitch", ::TeleportSpot, (-1511.28, 1661.5, 170.125));
    }
    else if( getdvar("mapname") == "mp_drivein")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (-59.2954, 1076.22, 252.125));
        self add_option("map teleports", "watching Silver Screen by Max", ::TeleportSpot, (30.0857, -753.733, 200.125));
        self add_option("map teleports", "ive lost my mind", ::TeleportSpot, (-1560.89, -814.222, 218.125));
    }
    else if( getdvar("mapname") == "mp_area51")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "window spot 1", ::TeleportSpot, (-1641.6, 1065.83, 184.625));
        self add_option("map teleports", "window spot 2", ::TeleportSpot, (-736.604, 441.641, 156.125));
        self add_option("map teleports", "window spot 3", ::TeleportSpot, (-368.359, 2016.3, 164.125));
        self add_option("map teleports", "window spot 4", ::TeleportSpot, (833.108, 403.641, 196.125));
        self add_option("map teleports", "random spot", ::TeleportSpot, (668.576, -1613.22, 265.125));
        self add_option("map teleports", "ladder spot 1", ::TeleportSpot, (607.473, -1887.64, 229.125));
        self add_option("map teleports", "ladder spot 2", ::TeleportSpot, (-1593.01, -1028.58, 99.125));
    }
    else if( getdvar("mapname") == "mp_golfcourse")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (-1351.6, -1145.11, 20.822));
        self add_option("map teleports", "high spot 1", ::TeleportSpot, (898.527, 680.206, 31.7));
        self add_option("map teleports", "high spot 2", ::TeleportSpot, (364.068, -152.901, -27.8634));
        self add_option("map teleports", "suicide spot", ::TeleportSpot, (-3295.99, 1407.71, -179.875));
        self add_option("map teleports", "out of map spot", ::TeleportSpot, (-1616.01, -2658.39, 136.125));
    }
    else if( getdvar("mapname") == "mp_silo")
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "main trickshot", ::TeleportSpot, (656.123, 2474.75, 373.289));
        self add_option("map teleports", "window spot 1", ::TeleportSpot, (-726.367, 596.721, 387.817));
        self add_option("map teleports", "window spot 2", ::TeleportSpot, (-725.957, -628.974, 220.803));
    }
    else
    {
        self add_menu("map teleports", "teleport menu");
        self add_option("map teleports", "^1broken", ::test);
    }
}