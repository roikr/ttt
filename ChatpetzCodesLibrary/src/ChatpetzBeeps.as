package {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;

	/**
	 * @author roikr
	 */
	public class ChatpetzBeeps {
		
		/*
		[Embed(source="../assets/256/sn2_8_000.mp3")] private static var sn2_8_000:Class;
		[Embed(source="../assets/256/sn2_8_001.mp3")] private static var sn2_8_001:Class;
		[Embed(source="../assets/256/sn2_8_002.mp3")] private static var sn2_8_002:Class;
		[Embed(source="../assets/256/sn2_8_003.mp3")] private static var sn2_8_003:Class;
		[Embed(source="../assets/256/sn2_8_004.mp3")] private static var sn2_8_004:Class;
		[Embed(source="../assets/256/sn2_8_005.mp3")] private static var sn2_8_005:Class;
		[Embed(source="../assets/256/sn2_8_006.mp3")] private static var sn2_8_006:Class;
		[Embed(source="../assets/256/sn2_8_007.mp3")] private static var sn2_8_007:Class;
		[Embed(source="../assets/256/sn2_8_008.mp3")] private static var sn2_8_008:Class;
		[Embed(source="../assets/256/sn2_8_009.mp3")] private static var sn2_8_009:Class;
		[Embed(source="../assets/256/sn2_8_010.mp3")] private static var sn2_8_010:Class;
		[Embed(source="../assets/256/sn2_8_011.mp3")] private static var sn2_8_011:Class;
		[Embed(source="../assets/256/sn2_8_012.mp3")] private static var sn2_8_012:Class;
		[Embed(source="../assets/256/sn2_8_013.mp3")] private static var sn2_8_013:Class;
		[Embed(source="../assets/256/sn2_8_014.mp3")] private static var sn2_8_014:Class;
		[Embed(source="../assets/256/sn2_8_015.mp3")] private static var sn2_8_015:Class;
		[Embed(source="../assets/256/sn2_8_016.mp3")] private static var sn2_8_016:Class;
		[Embed(source="../assets/256/sn2_8_017.mp3")] private static var sn2_8_017:Class;
		[Embed(source="../assets/256/sn2_8_018.mp3")] private static var sn2_8_018:Class;
		[Embed(source="../assets/256/sn2_8_019.mp3")] private static var sn2_8_019:Class;
		[Embed(source="../assets/256/sn2_8_020.mp3")] private static var sn2_8_020:Class;
		[Embed(source="../assets/256/sn2_8_021.mp3")] private static var sn2_8_021:Class;
		[Embed(source="../assets/256/sn2_8_022.mp3")] private static var sn2_8_022:Class;
		[Embed(source="../assets/256/sn2_8_023.mp3")] private static var sn2_8_023:Class;
		[Embed(source="../assets/256/sn2_8_024.mp3")] private static var sn2_8_024:Class;
		[Embed(source="../assets/256/sn2_8_025.mp3")] private static var sn2_8_025:Class;
		[Embed(source="../assets/256/sn2_8_026.mp3")] private static var sn2_8_026:Class;
		[Embed(source="../assets/256/sn2_8_027.mp3")] private static var sn2_8_027:Class;
		[Embed(source="../assets/256/sn2_8_028.mp3")] private static var sn2_8_028:Class;
		[Embed(source="../assets/256/sn2_8_029.mp3")] private static var sn2_8_029:Class;
		[Embed(source="../assets/256/sn2_8_030.mp3")] private static var sn2_8_030:Class;
		[Embed(source="../assets/256/sn2_8_031.mp3")] private static var sn2_8_031:Class;
		[Embed(source="../assets/256/sn2_8_032.mp3")] private static var sn2_8_032:Class;
		[Embed(source="../assets/256/sn2_8_033.mp3")] private static var sn2_8_033:Class;
		[Embed(source="../assets/256/sn2_8_034.mp3")] private static var sn2_8_034:Class;
		[Embed(source="../assets/256/sn2_8_035.mp3")] private static var sn2_8_035:Class;
		[Embed(source="../assets/256/sn2_8_036.mp3")] private static var sn2_8_036:Class;
		[Embed(source="../assets/256/sn2_8_037.mp3")] private static var sn2_8_037:Class;
		[Embed(source="../assets/256/sn2_8_038.mp3")] private static var sn2_8_038:Class;
		[Embed(source="../assets/256/sn2_8_039.mp3")] private static var sn2_8_039:Class;
		[Embed(source="../assets/256/sn2_8_040.mp3")] private static var sn2_8_040:Class;
		[Embed(source="../assets/256/sn2_8_041.mp3")] private static var sn2_8_041:Class;
		[Embed(source="../assets/256/sn2_8_042.mp3")] private static var sn2_8_042:Class;
		[Embed(source="../assets/256/sn2_8_043.mp3")] private static var sn2_8_043:Class;
		[Embed(source="../assets/256/sn2_8_044.mp3")] private static var sn2_8_044:Class;
		[Embed(source="../assets/256/sn2_8_045.mp3")] private static var sn2_8_045:Class;
		[Embed(source="../assets/256/sn2_8_046.mp3")] private static var sn2_8_046:Class;
		[Embed(source="../assets/256/sn2_8_047.mp3")] private static var sn2_8_047:Class;
		[Embed(source="../assets/256/sn2_8_048.mp3")] private static var sn2_8_048:Class;
		[Embed(source="../assets/256/sn2_8_049.mp3")] private static var sn2_8_049:Class;
		[Embed(source="../assets/256/sn2_8_050.mp3")] private static var sn2_8_050:Class;
		[Embed(source="../assets/256/sn2_8_051.mp3")] private static var sn2_8_051:Class;
		[Embed(source="../assets/256/sn2_8_052.mp3")] private static var sn2_8_052:Class;
		[Embed(source="../assets/256/sn2_8_053.mp3")] private static var sn2_8_053:Class;
		[Embed(source="../assets/256/sn2_8_054.mp3")] private static var sn2_8_054:Class;
		[Embed(source="../assets/256/sn2_8_055.mp3")] private static var sn2_8_055:Class;
		[Embed(source="../assets/256/sn2_8_056.mp3")] private static var sn2_8_056:Class;
		[Embed(source="../assets/256/sn2_8_057.mp3")] private static var sn2_8_057:Class;
		[Embed(source="../assets/256/sn2_8_058.mp3")] private static var sn2_8_058:Class;
		[Embed(source="../assets/256/sn2_8_059.mp3")] private static var sn2_8_059:Class;
		[Embed(source="../assets/256/sn2_8_060.mp3")] private static var sn2_8_060:Class;
		[Embed(source="../assets/256/sn2_8_061.mp3")] private static var sn2_8_061:Class;
		[Embed(source="../assets/256/sn2_8_062.mp3")] private static var sn2_8_062:Class;
		[Embed(source="../assets/256/sn2_8_063.mp3")] private static var sn2_8_063:Class;
		[Embed(source="../assets/256/sn2_8_064.mp3")] private static var sn2_8_064:Class;
		[Embed(source="../assets/256/sn2_8_065.mp3")] private static var sn2_8_065:Class;
		[Embed(source="../assets/256/sn2_8_066.mp3")] private static var sn2_8_066:Class;
		[Embed(source="../assets/256/sn2_8_067.mp3")] private static var sn2_8_067:Class;
		[Embed(source="../assets/256/sn2_8_068.mp3")] private static var sn2_8_068:Class;
		[Embed(source="../assets/256/sn2_8_069.mp3")] private static var sn2_8_069:Class;
		[Embed(source="../assets/256/sn2_8_070.mp3")] private static var sn2_8_070:Class;
		[Embed(source="../assets/256/sn2_8_071.mp3")] private static var sn2_8_071:Class;
		[Embed(source="../assets/256/sn2_8_072.mp3")] private static var sn2_8_072:Class;
		[Embed(source="../assets/256/sn2_8_073.mp3")] private static var sn2_8_073:Class;
		[Embed(source="../assets/256/sn2_8_074.mp3")] private static var sn2_8_074:Class;
		[Embed(source="../assets/256/sn2_8_075.mp3")] private static var sn2_8_075:Class;
		[Embed(source="../assets/256/sn2_8_076.mp3")] private static var sn2_8_076:Class;
		[Embed(source="../assets/256/sn2_8_077.mp3")] private static var sn2_8_077:Class;
		[Embed(source="../assets/256/sn2_8_078.mp3")] private static var sn2_8_078:Class;
		[Embed(source="../assets/256/sn2_8_079.mp3")] private static var sn2_8_079:Class;
		[Embed(source="../assets/256/sn2_8_080.mp3")] private static var sn2_8_080:Class;
		[Embed(source="../assets/256/sn2_8_081.mp3")] private static var sn2_8_081:Class;
		[Embed(source="../assets/256/sn2_8_082.mp3")] private static var sn2_8_082:Class;
		[Embed(source="../assets/256/sn2_8_083.mp3")] private static var sn2_8_083:Class;
		[Embed(source="../assets/256/sn2_8_084.mp3")] private static var sn2_8_084:Class;
		[Embed(source="../assets/256/sn2_8_085.mp3")] private static var sn2_8_085:Class;
		[Embed(source="../assets/256/sn2_8_086.mp3")] private static var sn2_8_086:Class;
		[Embed(source="../assets/256/sn2_8_087.mp3")] private static var sn2_8_087:Class;
		[Embed(source="../assets/256/sn2_8_088.mp3")] private static var sn2_8_088:Class;
		[Embed(source="../assets/256/sn2_8_089.mp3")] private static var sn2_8_089:Class;
		[Embed(source="../assets/256/sn2_8_090.mp3")] private static var sn2_8_090:Class;
		[Embed(source="../assets/256/sn2_8_091.mp3")] private static var sn2_8_091:Class;
		[Embed(source="../assets/256/sn2_8_092.mp3")] private static var sn2_8_092:Class;
		[Embed(source="../assets/256/sn2_8_093.mp3")] private static var sn2_8_093:Class;
		[Embed(source="../assets/256/sn2_8_094.mp3")] private static var sn2_8_094:Class;
		[Embed(source="../assets/256/sn2_8_095.mp3")] private static var sn2_8_095:Class;
		[Embed(source="../assets/256/sn2_8_096.mp3")] private static var sn2_8_096:Class;
		[Embed(source="../assets/256/sn2_8_097.mp3")] private static var sn2_8_097:Class;
		[Embed(source="../assets/256/sn2_8_098.mp3")] private static var sn2_8_098:Class;
		[Embed(source="../assets/256/sn2_8_099.mp3")] private static var sn2_8_099:Class;
		[Embed(source="../assets/256/sn2_8_100.mp3")] private static var sn2_8_100:Class;
		[Embed(source="../assets/256/sn2_8_101.mp3")] private static var sn2_8_101:Class;
		[Embed(source="../assets/256/sn2_8_102.mp3")] private static var sn2_8_102:Class;
		[Embed(source="../assets/256/sn2_8_103.mp3")] private static var sn2_8_103:Class;
		[Embed(source="../assets/256/sn2_8_104.mp3")] private static var sn2_8_104:Class;
		[Embed(source="../assets/256/sn2_8_105.mp3")] private static var sn2_8_105:Class;
		[Embed(source="../assets/256/sn2_8_106.mp3")] private static var sn2_8_106:Class;
		[Embed(source="../assets/256/sn2_8_107.mp3")] private static var sn2_8_107:Class;
		[Embed(source="../assets/256/sn2_8_108.mp3")] private static var sn2_8_108:Class;
		[Embed(source="../assets/256/sn2_8_109.mp3")] private static var sn2_8_109:Class;
		[Embed(source="../assets/256/sn2_8_110.mp3")] private static var sn2_8_110:Class;
		[Embed(source="../assets/256/sn2_8_111.mp3")] private static var sn2_8_111:Class;
		[Embed(source="../assets/256/sn2_8_112.mp3")] private static var sn2_8_112:Class;
		[Embed(source="../assets/256/sn2_8_113.mp3")] private static var sn2_8_113:Class;
		[Embed(source="../assets/256/sn2_8_114.mp3")] private static var sn2_8_114:Class;
		[Embed(source="../assets/256/sn2_8_115.mp3")] private static var sn2_8_115:Class;
		[Embed(source="../assets/256/sn2_8_116.mp3")] private static var sn2_8_116:Class;
		[Embed(source="../assets/256/sn2_8_117.mp3")] private static var sn2_8_117:Class;
		[Embed(source="../assets/256/sn2_8_118.mp3")] private static var sn2_8_118:Class;
		[Embed(source="../assets/256/sn2_8_119.mp3")] private static var sn2_8_119:Class;
		[Embed(source="../assets/256/sn2_8_120.mp3")] private static var sn2_8_120:Class;
		[Embed(source="../assets/256/sn2_8_121.mp3")] private static var sn2_8_121:Class;
		[Embed(source="../assets/256/sn2_8_122.mp3")] private static var sn2_8_122:Class;
		[Embed(source="../assets/256/sn2_8_123.mp3")] private static var sn2_8_123:Class;
		[Embed(source="../assets/256/sn2_8_124.mp3")] private static var sn2_8_124:Class;
		[Embed(source="../assets/256/sn2_8_125.mp3")] private static var sn2_8_125:Class;
		[Embed(source="../assets/256/sn2_8_126.mp3")] private static var sn2_8_126:Class;
		[Embed(source="../assets/256/sn2_8_127.mp3")] private static var sn2_8_127:Class;
		[Embed(source="../assets/256/sn2_8_128.mp3")] private static var sn2_8_128:Class;
		[Embed(source="../assets/256/sn2_8_129.mp3")] private static var sn2_8_129:Class;
		[Embed(source="../assets/256/sn2_8_130.mp3")] private static var sn2_8_130:Class;
		[Embed(source="../assets/256/sn2_8_131.mp3")] private static var sn2_8_131:Class;
		[Embed(source="../assets/256/sn2_8_132.mp3")] private static var sn2_8_132:Class;
		[Embed(source="../assets/256/sn2_8_133.mp3")] private static var sn2_8_133:Class;
		[Embed(source="../assets/256/sn2_8_134.mp3")] private static var sn2_8_134:Class;
		[Embed(source="../assets/256/sn2_8_135.mp3")] private static var sn2_8_135:Class;
		[Embed(source="../assets/256/sn2_8_136.mp3")] private static var sn2_8_136:Class;
		[Embed(source="../assets/256/sn2_8_137.mp3")] private static var sn2_8_137:Class;
		[Embed(source="../assets/256/sn2_8_138.mp3")] private static var sn2_8_138:Class;
		[Embed(source="../assets/256/sn2_8_139.mp3")] private static var sn2_8_139:Class;
		[Embed(source="../assets/256/sn2_8_140.mp3")] private static var sn2_8_140:Class;
		[Embed(source="../assets/256/sn2_8_141.mp3")] private static var sn2_8_141:Class;
		[Embed(source="../assets/256/sn2_8_142.mp3")] private static var sn2_8_142:Class;
		[Embed(source="../assets/256/sn2_8_143.mp3")] private static var sn2_8_143:Class;
		[Embed(source="../assets/256/sn2_8_144.mp3")] private static var sn2_8_144:Class;
		[Embed(source="../assets/256/sn2_8_145.mp3")] private static var sn2_8_145:Class;
		[Embed(source="../assets/256/sn2_8_146.mp3")] private static var sn2_8_146:Class;
		[Embed(source="../assets/256/sn2_8_147.mp3")] private static var sn2_8_147:Class;
		[Embed(source="../assets/256/sn2_8_148.mp3")] private static var sn2_8_148:Class;
		[Embed(source="../assets/256/sn2_8_149.mp3")] private static var sn2_8_149:Class;
		[Embed(source="../assets/256/sn2_8_150.mp3")] private static var sn2_8_150:Class;
		[Embed(source="../assets/256/sn2_8_151.mp3")] private static var sn2_8_151:Class;
		[Embed(source="../assets/256/sn2_8_152.mp3")] private static var sn2_8_152:Class;
		[Embed(source="../assets/256/sn2_8_153.mp3")] private static var sn2_8_153:Class;
		[Embed(source="../assets/256/sn2_8_154.mp3")] private static var sn2_8_154:Class;
		[Embed(source="../assets/256/sn2_8_155.mp3")] private static var sn2_8_155:Class;
		[Embed(source="../assets/256/sn2_8_156.mp3")] private static var sn2_8_156:Class;
		[Embed(source="../assets/256/sn2_8_157.mp3")] private static var sn2_8_157:Class;
		[Embed(source="../assets/256/sn2_8_158.mp3")] private static var sn2_8_158:Class;
		[Embed(source="../assets/256/sn2_8_159.mp3")] private static var sn2_8_159:Class;
		[Embed(source="../assets/256/sn2_8_160.mp3")] private static var sn2_8_160:Class;
		[Embed(source="../assets/256/sn2_8_161.mp3")] private static var sn2_8_161:Class;
		[Embed(source="../assets/256/sn2_8_162.mp3")] private static var sn2_8_162:Class;
		[Embed(source="../assets/256/sn2_8_163.mp3")] private static var sn2_8_163:Class;
		[Embed(source="../assets/256/sn2_8_164.mp3")] private static var sn2_8_164:Class;
		[Embed(source="../assets/256/sn2_8_165.mp3")] private static var sn2_8_165:Class;
		[Embed(source="../assets/256/sn2_8_166.mp3")] private static var sn2_8_166:Class;
		[Embed(source="../assets/256/sn2_8_167.mp3")] private static var sn2_8_167:Class;
		[Embed(source="../assets/256/sn2_8_168.mp3")] private static var sn2_8_168:Class;
		[Embed(source="../assets/256/sn2_8_169.mp3")] private static var sn2_8_169:Class;
		[Embed(source="../assets/256/sn2_8_170.mp3")] private static var sn2_8_170:Class;
		[Embed(source="../assets/256/sn2_8_171.mp3")] private static var sn2_8_171:Class;
		[Embed(source="../assets/256/sn2_8_172.mp3")] private static var sn2_8_172:Class;
		[Embed(source="../assets/256/sn2_8_173.mp3")] private static var sn2_8_173:Class;
		[Embed(source="../assets/256/sn2_8_174.mp3")] private static var sn2_8_174:Class;
		[Embed(source="../assets/256/sn2_8_175.mp3")] private static var sn2_8_175:Class;
		[Embed(source="../assets/256/sn2_8_176.mp3")] private static var sn2_8_176:Class;
		[Embed(source="../assets/256/sn2_8_177.mp3")] private static var sn2_8_177:Class;
		[Embed(source="../assets/256/sn2_8_178.mp3")] private static var sn2_8_178:Class;
		[Embed(source="../assets/256/sn2_8_179.mp3")] private static var sn2_8_179:Class;
		[Embed(source="../assets/256/sn2_8_180.mp3")] private static var sn2_8_180:Class;
		[Embed(source="../assets/256/sn2_8_181.mp3")] private static var sn2_8_181:Class;
		[Embed(source="../assets/256/sn2_8_182.mp3")] private static var sn2_8_182:Class;
		[Embed(source="../assets/256/sn2_8_183.mp3")] private static var sn2_8_183:Class;
		[Embed(source="../assets/256/sn2_8_184.mp3")] private static var sn2_8_184:Class;
		[Embed(source="../assets/256/sn2_8_185.mp3")] private static var sn2_8_185:Class;
		[Embed(source="../assets/256/sn2_8_186.mp3")] private static var sn2_8_186:Class;
		[Embed(source="../assets/256/sn2_8_187.mp3")] private static var sn2_8_187:Class;
		[Embed(source="../assets/256/sn2_8_188.mp3")] private static var sn2_8_188:Class;
		[Embed(source="../assets/256/sn2_8_189.mp3")] private static var sn2_8_189:Class;
		[Embed(source="../assets/256/sn2_8_190.mp3")] private static var sn2_8_190:Class;
		[Embed(source="../assets/256/sn2_8_191.mp3")] private static var sn2_8_191:Class;
		[Embed(source="../assets/256/sn2_8_192.mp3")] private static var sn2_8_192:Class;
		[Embed(source="../assets/256/sn2_8_193.mp3")] private static var sn2_8_193:Class;
		[Embed(source="../assets/256/sn2_8_194.mp3")] private static var sn2_8_194:Class;
		[Embed(source="../assets/256/sn2_8_195.mp3")] private static var sn2_8_195:Class;
		[Embed(source="../assets/256/sn2_8_196.mp3")] private static var sn2_8_196:Class;
		[Embed(source="../assets/256/sn2_8_197.mp3")] private static var sn2_8_197:Class;
		[Embed(source="../assets/256/sn2_8_198.mp3")] private static var sn2_8_198:Class;
		[Embed(source="../assets/256/sn2_8_199.mp3")] private static var sn2_8_199:Class;
		[Embed(source="../assets/256/sn2_8_200.mp3")] private static var sn2_8_200:Class;
		[Embed(source="../assets/256/sn2_8_201.mp3")] private static var sn2_8_201:Class;
		[Embed(source="../assets/256/sn2_8_202.mp3")] private static var sn2_8_202:Class;
		[Embed(source="../assets/256/sn2_8_203.mp3")] private static var sn2_8_203:Class;
		[Embed(source="../assets/256/sn2_8_204.mp3")] private static var sn2_8_204:Class;
		[Embed(source="../assets/256/sn2_8_205.mp3")] private static var sn2_8_205:Class;
		[Embed(source="../assets/256/sn2_8_206.mp3")] private static var sn2_8_206:Class;
		[Embed(source="../assets/256/sn2_8_207.mp3")] private static var sn2_8_207:Class;
		[Embed(source="../assets/256/sn2_8_208.mp3")] private static var sn2_8_208:Class;
		[Embed(source="../assets/256/sn2_8_209.mp3")] private static var sn2_8_209:Class;
		[Embed(source="../assets/256/sn2_8_210.mp3")] private static var sn2_8_210:Class;
		[Embed(source="../assets/256/sn2_8_211.mp3")] private static var sn2_8_211:Class;
		[Embed(source="../assets/256/sn2_8_212.mp3")] private static var sn2_8_212:Class;
		[Embed(source="../assets/256/sn2_8_213.mp3")] private static var sn2_8_213:Class;
		[Embed(source="../assets/256/sn2_8_214.mp3")] private static var sn2_8_214:Class;
		[Embed(source="../assets/256/sn2_8_215.mp3")] private static var sn2_8_215:Class;
		[Embed(source="../assets/256/sn2_8_216.mp3")] private static var sn2_8_216:Class;
		[Embed(source="../assets/256/sn2_8_217.mp3")] private static var sn2_8_217:Class;
		[Embed(source="../assets/256/sn2_8_218.mp3")] private static var sn2_8_218:Class;
		[Embed(source="../assets/256/sn2_8_219.mp3")] private static var sn2_8_219:Class;
		[Embed(source="../assets/256/sn2_8_220.mp3")] private static var sn2_8_220:Class;
		[Embed(source="../assets/256/sn2_8_221.mp3")] private static var sn2_8_221:Class;
		[Embed(source="../assets/256/sn2_8_222.mp3")] private static var sn2_8_222:Class;
		[Embed(source="../assets/256/sn2_8_223.mp3")] private static var sn2_8_223:Class;
		[Embed(source="../assets/256/sn2_8_224.mp3")] private static var sn2_8_224:Class;
		[Embed(source="../assets/256/sn2_8_225.mp3")] private static var sn2_8_225:Class;
		[Embed(source="../assets/256/sn2_8_226.mp3")] private static var sn2_8_226:Class;
		[Embed(source="../assets/256/sn2_8_227.mp3")] private static var sn2_8_227:Class;
		[Embed(source="../assets/256/sn2_8_228.mp3")] private static var sn2_8_228:Class;
		[Embed(source="../assets/256/sn2_8_229.mp3")] private static var sn2_8_229:Class;
		[Embed(source="../assets/256/sn2_8_230.mp3")] private static var sn2_8_230:Class;
		[Embed(source="../assets/256/sn2_8_231.mp3")] private static var sn2_8_231:Class;
		[Embed(source="../assets/256/sn2_8_232.mp3")] private static var sn2_8_232:Class;
		[Embed(source="../assets/256/sn2_8_233.mp3")] private static var sn2_8_233:Class;
		[Embed(source="../assets/256/sn2_8_234.mp3")] private static var sn2_8_234:Class;
		[Embed(source="../assets/256/sn2_8_235.mp3")] private static var sn2_8_235:Class;
		[Embed(source="../assets/256/sn2_8_236.mp3")] private static var sn2_8_236:Class;
		[Embed(source="../assets/256/sn2_8_237.mp3")] private static var sn2_8_237:Class;
		[Embed(source="../assets/256/sn2_8_238.mp3")] private static var sn2_8_238:Class;
		[Embed(source="../assets/256/sn2_8_239.mp3")] private static var sn2_8_239:Class;
		[Embed(source="../assets/256/sn2_8_240.mp3")] private static var sn2_8_240:Class;
		[Embed(source="../assets/256/sn2_8_241.mp3")] private static var sn2_8_241:Class;
		[Embed(source="../assets/256/sn2_8_242.mp3")] private static var sn2_8_242:Class;
		[Embed(source="../assets/256/sn2_8_243.mp3")] private static var sn2_8_243:Class;
		[Embed(source="../assets/256/sn2_8_244.mp3")] private static var sn2_8_244:Class;
		[Embed(source="../assets/256/sn2_8_245.mp3")] private static var sn2_8_245:Class;
		[Embed(source="../assets/256/sn2_8_246.mp3")] private static var sn2_8_246:Class;
		[Embed(source="../assets/256/sn2_8_247.mp3")] private static var sn2_8_247:Class;
		[Embed(source="../assets/256/sn2_8_248.mp3")] private static var sn2_8_248:Class;
		[Embed(source="../assets/256/sn2_8_249.mp3")] private static var sn2_8_249:Class;
		[Embed(source="../assets/256/sn2_8_250.mp3")] private static var sn2_8_250:Class;
		[Embed(source="../assets/256/sn2_8_251.mp3")] private static var sn2_8_251:Class;
		[Embed(source="../assets/256/sn2_8_252.mp3")] private static var sn2_8_252:Class;
		[Embed(source="../assets/256/sn2_8_253.mp3")] private static var sn2_8_253:Class;
		[Embed(source="../assets/256/sn2_8_254.mp3")] private static var sn2_8_254:Class;
		[Embed(source="../assets/256/sn2_8_255.mp3")] private static var sn2_8_255:Class;
		*/
		
		private static var importer:Array = [
            sn2_8_033,
			sn2_8_034,
			sn2_8_035,
			sn2_8_036,
			sn2_8_037,
			sn2_8_038,
			sn2_8_039,
			sn2_8_040,
			sn2_8_041,
			sn2_8_042,
			sn2_8_043,
			sn2_8_044,
			sn2_8_066,
			sn2_8_092,
			sn2_8_095,
			sn2_8_096,
			sn2_8_100,
			sn2_8_101,
			sn2_8_102,
			sn2_8_103,
			sn2_8_104,
			sn2_8_105,
			sn2_8_106,
			sn2_8_107,
			sn2_8_108,
			sn2_8_109,
			sn2_8_110,
			sn2_8_111,
			sn2_8_112,
			sn2_8_113,
			sn2_8_114,
			sn2_8_115,
			sn2_8_116,
			sn2_8_117,
			sn2_8_118,
			sn2_8_119,
			sn2_8_120,
			sn2_8_121,
			sn2_8_122,
			sn2_8_123,
			sn2_8_124,
			sn2_8_125,
			sn2_8_126,
			sn2_8_127,
			sn2_8_128,
			sn2_8_129,
			sn2_8_130,
			sn2_8_131,
			sn2_8_132,
			sn2_8_133,
			sn2_8_134,
			sn2_8_135,
			sn2_8_136,
			sn2_8_137,
			sn2_8_138,
			sn2_8_139,
			sn2_8_140,
			sn2_8_141,
			sn2_8_142,
			sn2_8_143,
			sn2_8_144,
			sn2_8_145,
			sn2_8_146,
			sn2_8_147,
			sn2_8_148,
			sn2_8_149,
			sn2_8_150,
			sn2_8_151,
			sn2_8_152,
			sn2_8_153,
			sn2_8_154,
			sn2_8_155,
			sn2_8_156,
			sn2_8_157,
			sn2_8_158,
			sn2_8_159,
			sn2_8_160,
			sn2_8_161,
			sn2_8_162,
			sn2_8_163,
			sn2_8_164,
			sn2_8_165,
			sn2_8_166,
			sn2_8_167,
			sn2_8_168,
			sn2_8_169,
			sn2_8_170,
			sn2_8_171,
			sn2_8_172,
			sn2_8_173,
			sn2_8_174,
			sn2_8_175,
			sn2_8_176,
			sn2_8_177,
			sn2_8_178,
			sn2_8_179,
			sn2_8_180,
			sn2_8_181,
			sn2_8_182,
			sn2_8_183,
			sn2_8_184,
			sn2_8_185,
			sn2_8_186,
			sn2_8_187,
			sn2_8_188,
			sn2_8_189,
			sn2_8_190,
			sn2_8_191,
			sn2_8_192,
			sn2_8_193,
			sn2_8_194,
			sn2_8_195,
			sn2_8_196,
			sn2_8_197,
			sn2_8_198,
			sn2_8_199
            
        ];
		
		
	}
	
}