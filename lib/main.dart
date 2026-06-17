import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum AppLanguage { ru, en }

class AppSettings extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  AppLanguage language = AppLanguage.ru;

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  void setLanguage(AppLanguage lang) {
    language = lang;
    notifyListeners();
  }
}

class AppSettingsScope extends InheritedNotifier<AppSettings> {
  const AppSettingsScope({
    super.key,
    required AppSettings settings,
    required super.child,
  }) : super(notifier: settings);

  static AppSettings of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppSettingsScope>()!
        .notifier!;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppSettings settings = AppSettings();

  @override
  Widget build(BuildContext context) {
    return AppSettingsScope(
      settings: settings,
      child: AnimatedBuilder(
        animation: settings,
        builder: (context, _) {
          return MaterialApp(
            title: 'Minecraft Mob Encyclopedia',
            debugShowCheckedModeBanner: false,
            themeMode: settings.themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: const Color(0xFFF5F5F5),
              cardColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4CAF50),
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF121212),
              cardColor: const Color(0xFF1E1E1E),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1E1E1E),
                elevation: 0,
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4CAF50),
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

enum MobType { hostile, neutral }

class Mob {
  final String nameRu;
  final String nameEn;
  final String descriptionRu;
  final String descriptionEn;
  final int health;
  final MobType type;
  final String imagePath;

  const Mob({
    required this.nameRu,
    required this.nameEn,
    required this.descriptionRu,
    required this.descriptionEn,
    required this.health,
    required this.type,
    required this.imagePath,
  });

  String name(AppLanguage lang) => lang == AppLanguage.ru ? nameRu : nameEn;

  String description(AppLanguage lang) =>
      lang == AppLanguage.ru ? descriptionRu : descriptionEn;

  String typeLabel(AppLanguage lang) {
    if (lang == AppLanguage.ru) {
      return type == MobType.hostile ? 'Враждебный' : 'Нейтральный';
    }
    return type == MobType.hostile ? 'Hostile' : 'Neutral';
  }

  Color get typeColor => type == MobType.hostile ? Colors.redAccent : Colors.amber;
}

final List<Mob> mobs = [
  const Mob(
    nameRu: 'Крипер',
    nameEn: 'Creeper',
    descriptionRu:
        'Молчаливый зелёный моб, который подкрадывается и взрывается рядом с игроком. '
        'Взрыв повреждает не только игрока, но и окружающий ландшафт. '
        'Один из самых узнаваемых символов Minecraft.',
    descriptionEn:
        'A silent green mob that sneaks up and explodes near the player. '
        'The explosion damages not only the player but also the surrounding terrain. '
        'One of the most recognizable symbols of Minecraft.',
    health: 20,
    type: MobType.hostile,
    imagePath: 'assets/images/creeper.png',
  ),
  const Mob(
    nameRu: 'Зомби',
    nameEn: 'Zombie',
    descriptionRu:
        'Медленный враждебный моб, появляющийся ночью или в тёмных местах. '
        'Атакует игрока вблизи и может ломать двери в некоторых режимах. '
        'Иногда сжигается солнечным светом, если не успевает скрыться.',
    descriptionEn:
        'A slow hostile mob that appears at night or in dark places. '
        'Attacks the player up close and can break doors in some game modes. '
        'Sometimes burns in sunlight if it fails to find shade in time.',
    health: 20,
    type: MobType.hostile,
    imagePath: 'assets/images/zombie.png',
  ),
  const Mob(
    nameRu: 'Скелет',
    nameEn: 'Skeleton',
    descriptionRu:
        'Враждебный моб, атакующий игрока на расстоянии с помощью лука и стрел. '
        'Обычно появляется в тёмных пещерах и ночью на поверхности. '
        'Под солнечными лучами загорается, как и зомби.',
    descriptionEn:
        'A hostile mob that attacks the player from a distance with a bow and arrows. '
        'Usually appears in dark caves and on the surface at night. '
        'Catches fire in sunlight, just like a zombie.',
    health: 20,
    type: MobType.hostile,
    imagePath: 'assets/images/skeleton.png',
  ),
  const Mob(
    nameRu: 'Паук',
    nameEn: 'Spider',
    descriptionRu:
        'Враждебный моб, способный взбираться по стенам и нападать в темноте. '
        'При дневном свете часто становится нейтральным, если игрок не атакует первым. '
        'Двигается быстро и может застать игрока врасплох.',
    descriptionEn:
        'A hostile mob able to climb walls and attack in the dark. '
        'In daylight it often becomes neutral unless the player attacks first. '
        'Moves quickly and can catch the player off guard.',
    health: 16,
    type: MobType.hostile,
    imagePath: 'assets/images/spider.png',
  ),
  const Mob(
    nameRu: 'Эндермен',
    nameEn: 'Enderman',
    descriptionRu:
        'Высокий и таинственный моб, способный телепортироваться на короткие расстояния. '
        'Становится враждебным только если игрок смотрит ему в глаза. '
        'Считается одним из самых опасных мобов в игре.',
    descriptionEn:
        'A tall and mysterious mob capable of teleporting short distances. '
        'Becomes hostile only if the player looks it in the eyes. '
        'Considered one of the most dangerous mobs in the game.',
    health: 40,
    type: MobType.neutral,
    imagePath: 'assets/images/enderman.png',
  ),
  const Mob(
    nameRu: 'Свинозомби',
    nameEn: 'Zombie Pigman',
    descriptionRu:
        'Обитатель Нижнего мира, вооружённый золотым мечом. '
        'Ведёт себя нейтрально, пока игрок не атакует его или его сородичей. '
        'После атаки на одного свинозомби в бой могут вступить остальные особи рядом.',
    descriptionEn:
        'A Nether dweller armed with a golden sword. '
        'Behaves neutrally until the player attacks it or its kin. '
        'After one is attacked, nearby zombie pigmen may join the fight.',
    health: 20,
    type: MobType.neutral,
    imagePath: 'assets/images/zombie_pigman.png',
  ),
  const Mob(
    nameRu: 'Слизень',
    nameEn: 'Slime',
    descriptionRu:
        'Желеобразный моб, который при уничтожении распадается на более мелких слизней. '
        'Атакует игрока, прыгая на него, нанося небольшой урон. '
        'Чаще всего встречается на равнинах и в болотистых биомах ночью.',
    descriptionEn:
        'A jelly-like mob that splits into smaller slimes when destroyed. '
        'Attacks the player by jumping on them, dealing minor damage. '
        'Most commonly found on plains and in swamp biomes at night.',
    health: 16,
    type: MobType.hostile,
    imagePath: 'assets/images/slime.png',
  ),
];

class Strings {
  final AppLanguage lang;
  Strings(this.lang);

  bool get isRu => lang == AppLanguage.ru;

  String get appTitle => isRu ? 'Энциклопедия мобов Minecraft' : 'Minecraft Mob Encyclopedia';
  String get settings => isRu ? 'Настройки' : 'Settings';
  String get compare => isRu ? 'Сравнение' : 'Compare';
  String get theme => isRu ? 'Тема' : 'Theme';
  String get language => isRu ? 'Язык' : 'Language';
  String get themeLight => isRu ? 'Светлая' : 'Light';
  String get themeDark => isRu ? 'Тёмная' : 'Dark';
  String get themeSystem => isRu ? 'Системная' : 'System';
  String get languageRu => isRu ? 'Русский' : 'Russian';
  String get languageEn => isRu ? 'Английский' : 'English';
  String get selectFirstMob => isRu ? 'Выберите первого моба' : 'Select first mob';
  String get selectSecondMob => isRu ? 'Выберите второго моба' : 'Select second mob';
  String get parameter => isRu ? 'Параметр' : 'Parameter';
  String get health => isRu ? 'Здоровье' : 'Health';
  String get type => isRu ? 'Тип' : 'Type';
  String get description => isRu ? 'Описание' : 'Description';
  String get pickBothMobs => isRu ? 'Выберите двух мобов для сравнения' : 'Pick two mobs to compare';
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    final s = Strings(settings.language);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            tooltip: s.compare,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CompareScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: s.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: mobs.length,
        itemBuilder: (context, index) {
          final mob = mobs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Hero(
                tag: mob.nameEn,
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(mob.imagePath),
                ),
              ),
              title: Text(
                mob.name(settings.language),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, size: 16, color: Colors.redAccent),
                    const SizedBox(width: 4),
                    Text('${mob.health} HP'),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: mob.typeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: mob.typeColor),
                      ),
                      child: Text(
                        mob.typeLabel(settings.language),
                        style: TextStyle(color: mob.typeColor, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(mob: mob),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Mob mob;

  const DetailScreen({super.key, required this.mob});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(mob.name(settings.language)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: mob.nameEn,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  mob.imagePath,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              mob.name(settings.language),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.favorite, color: Colors.redAccent),
                const SizedBox(width: 6),
                Text('${mob.health} HP', style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: mob.typeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: mob.typeColor),
                  ),
                  child: Text(
                    mob.typeLabel(settings.language),
                    style: TextStyle(
                      color: mob.typeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                mob.description(settings.language),
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    final s = Strings(settings.language);

    return Scaffold(
      appBar: AppBar(title: Text(s.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(s.theme, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          RadioListTile<ThemeMode>(
            title: Text(s.themeLight),
            value: ThemeMode.light,
            groupValue: settings.themeMode,
            onChanged: (mode) => settings.setThemeMode(mode!),
          ),
          RadioListTile<ThemeMode>(
            title: Text(s.themeDark),
            value: ThemeMode.dark,
            groupValue: settings.themeMode,
            onChanged: (mode) => settings.setThemeMode(mode!),
          ),
          RadioListTile<ThemeMode>(
            title: Text(s.themeSystem),
            value: ThemeMode.system,
            groupValue: settings.themeMode,
            onChanged: (mode) => settings.setThemeMode(mode!),
          ),
          const Divider(height: 32),
          Text(s.language, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          RadioListTile<AppLanguage>(
            title: Text(s.languageRu),
            value: AppLanguage.ru,
            groupValue: settings.language,
            onChanged: (lang) => settings.setLanguage(lang!),
          ),
          RadioListTile<AppLanguage>(
            title: Text(s.languageEn),
            value: AppLanguage.en,
            groupValue: settings.language,
            onChanged: (lang) => settings.setLanguage(lang!),
          ),
        ],
      ),
    );
  }
}

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  Mob? firstMob;
  Mob? secondMob;

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    final s = Strings(settings.language);

    return Scaffold(
      appBar: AppBar(title: Text(s.compare)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _MobDropdown(
                    hint: s.selectFirstMob,
                    value: firstMob,
                    language: settings.language,
                    onChanged: (mob) => setState(() => firstMob = mob),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MobDropdown(
                    hint: s.selectSecondMob,
                    value: secondMob,
                    language: settings.language,
                    onChanged: (mob) => setState(() => secondMob = mob),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: firstMob != null && secondMob != null
                  ? _ComparisonTable(first: firstMob!, second: secondMob!, s: s, language: settings.language)
                  : Center(
                      child: Text(
                        s.pickBothMobs,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobDropdown extends StatelessWidget {
  final String hint;
  final Mob? value;
  final AppLanguage language;
  final ValueChanged<Mob?> onChanged;

  const _MobDropdown({
    required this.hint,
    required this.value,
    required this.language,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Mob>(
      decoration: InputDecoration(
        labelText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      isExpanded: true,
      value: value,
      items: mobs.map((mob) {
        return DropdownMenuItem<Mob>(
          value: mob,
          child: Text(mob.name(language), overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  final Mob first;
  final Mob second;
  final Strings s;
  final AppLanguage language;

  const _ComparisonTable({
    required this.first,
    required this.second,
    required this.s,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _MobHeader(mob: first, language: language)),
              const SizedBox(width: 12),
              Expanded(child: _MobHeader(mob: second, language: language)),
            ],
          ),
          const SizedBox(height: 16),
          Table(
            border: TableBorder.all(color: Colors.grey.withOpacity(0.3)),
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: [
              _buildRow(s.health, '${first.health} HP', '${second.health} HP', context),
              _buildRow(
                s.type,
                first.typeLabel(language),
                second.typeLabel(language),
                context,
                colorA: first.typeColor,
                colorB: second.typeColor,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(first.description(language), style: const TextStyle(height: 1.4)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(second.description(language), style: const TextStyle(height: 1.4)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildRow(
    String label,
    String valueA,
    String valueB,
    BuildContext context, {
    Color? colorA,
    Color? colorB,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            valueA,
            textAlign: TextAlign.center,
            style: TextStyle(color: colorA, fontWeight: colorA != null ? FontWeight.bold : null),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            valueB,
            textAlign: TextAlign.center,
            style: TextStyle(color: colorB, fontWeight: colorB != null ? FontWeight.bold : null),
          ),
        ),
      ],
    );
  }
}

class _MobHeader extends StatelessWidget {
  final Mob mob;
  final AppLanguage language;

  const _MobHeader({required this.mob, required this.language});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage(mob.imagePath),
        ),
        const SizedBox(height: 8),
        Text(
          mob.name(language),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
