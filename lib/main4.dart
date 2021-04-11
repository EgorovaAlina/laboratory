import 'package:flutter/material.dart';

void main() {
  runApp(FilmsApp());
}

class Film {
  String title;
  String subtitle;
  String description;

  Film(this.title, this.subtitle, this.description);
}

class FilmsApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilmsAppState();
}

class _FilmsAppState extends State<FilmsApp> {
  FilmRouterDelegate _routerDelegate = FilmRouterDelegate();
  FilmRouteInformationParser _routeInformationParser = FilmRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Фильмы',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class FilmRouteInformationParser extends RouteInformationParser<FilmRoutePath> {
  @override
  Future<FilmRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length >= 2) {
      var remaining = uri.pathSegments[1];
      return FilmRoutePath.details(int.tryParse(remaining));
    } else {
      return FilmRoutePath.home();
    }
  }

  @override
  RouteInformation restoreRouteInformation(FilmRoutePath path) {
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/film/${path.id}');
    }
    return null;
  }
}

class FilmRouterDelegate extends RouterDelegate<FilmRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FilmRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  Film _selectedFilm;

  List<Film> films = [
    Film('Крестный отец', '1972, США, Драмы, Криминал, Зарубежные, 16+', ' Криминальная сага о сицилийской мафии в Нью-Йорке занимает вторую строчку в списке лучших фильмов за всю историю американского кинематографа, составленного Американским институтом киноискусства. И, что важно, в своих оценках этому фильму совпадают и зрители, и кинокритики, ищущие в картинах совсем разных впечатлений.',
    ),
    Film('Побег из Шоушенка', '1994, США, Драмы, Зарубежные, 16+', 'История о несгибаемой воле и целеустремленности Энди Дюфрейна на протяжении последних десяти лет возглавляет списки лучших фильмов всех времен по версии зрителей как в России, так и за рубежом.',
    ),
    Film('Форрест Гамп', '1994, США, Драмы, Зарубежные, Мелодрамы, 12+', 'Лучший фильм в карьере режиссера Роберта Земекиса и один из самых ярких образов Тома Хэнкса. В 1994 году «Форрест Гамп» стал самым кассовым фильмом, забрал 6 «Оскаров-1995», среди них три главных, и еще 38 кинонаград по всему миру.',
    ),
    Film('Король Лев', '1994, США, Драма, Приключения, Семейные, 0+', 'На момент выхода в 1994 году «Король Лев» стал самым кассовым анимационным фильмом в истории. Его рекорд был побит лишь девять лет спустя мультфильмом «В поисках Немо».',
    ),
    Film('Начало', '2010, США, Фантастика, Боевики, Триллеры, 12+', 'Пожалуй, лучший на сегодняшний день пример того, как можно сделать головокружительный блокбастер с мощной картинкой, который при этом требует вдумчивого просмотра и, возможно, не один раз.',
    ),
    Film('Матрица', '999, США, Фантастика, Боевики, Зарубежные, 16+', '«Матрица» ознаменовала собой начало нового тысячелетия: одним она дала новую философию, пересмотр природы реальности, нового героя, другим потрясающие визуальные эффекты, третьих увлекла сюжетом, и многим — разочарование уже ко второму фильму. И все же за последние восемнадцать лет только ленивый не процитировал в своем кино ту или иную сцену из «Матрицы».',
    ),
    Film('Титаник', '1997, США, Катастрофы, Драмы, Мелодрамы, 12+', 'Эпичный фильм-катастрофа Джеймса Кэмерона стал самым кассовым в истории кинематографа, пока не появился «Аватар» того же режиссера. В 1998 году «Титаник» был номинирован на 14 «Оскаров» и взял 11 из них.',
    ),

  ];

  FilmRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  FilmRoutePath get currentConfiguration => _selectedFilm == null
      ? FilmRoutePath.home()
      : FilmRoutePath.details(films.indexOf(_selectedFilm));

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('FilmsListPage'),
          child: FilmsListScreen(
            films: films,
            onTapped: _handleFilmTapped,
          ),
        ),
        if (_selectedFilm != null) FilmDetailsPage(film: _selectedFilm)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedFilm to null
        _selectedFilm = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(FilmRoutePath path) async {
    if (path.isDetailsPage) {
      _selectedFilm = films[path.id];
    }
  }

  void _handleFilmTapped(Film film) {
    _selectedFilm = film;
    notifyListeners();
  }
}

class FilmDetailsPage extends Page {
  final Film film;

  FilmDetailsPage({
    this.film,
  }) : super(key: ValueKey(film));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return FilmDetailsScreen(film: film);
      },
    );
  }
}

class FilmRoutePath {
  final int id;

  FilmRoutePath.home() : id = null;

  FilmRoutePath.details(this.id);

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}

class FilmsListScreen extends StatelessWidget {
  final List<Film> films;
  final ValueChanged<Film> onTapped;

  FilmsListScreen({
    @required this.films,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Фильмы,  которые необходимо посмотреть хотя бы раз в жизни'),
        textTheme: TextTheme(
            headline6:TextStyle (fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(
                0xFFFFFFFF) )
        ),
        backgroundColor: Color(0xFFFF3DEC),
      ),
      body: ListView(
        children: [
          for (var film in films)
            ListTile(
              title: Text(film.title),
              subtitle: Text(film.subtitle),
              onTap: () => onTapped(film),
            )
        ],
      ),
    );
  }
}

class FilmDetailsScreen extends StatelessWidget {
  final Film film;

  FilmDetailsScreen({
    @required this.film,
  });

  @override
  Widget build(BuildContext context) {
    final _sizeTextTitle = const TextStyle(fontSize: 25.0, color: Color(
        0xFFFF3DEC), fontWeight: FontWeight.bold, fontFamily: 'Hind',);
    final _sizeTextDescription = const TextStyle(fontSize: 15.0, fontFamily: 'Hind',);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF19CE9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (film != null) ...[

              Text(film.title, style:  _sizeTextTitle),
              Text(film.subtitle, style: Theme.of(context).textTheme.subtitle1),
              Container(margin: const EdgeInsets.only(top: 10),),
              Text(film.description, style: _sizeTextDescription,),

            ],
          ],
        ),
      ),
    );
  }
}
