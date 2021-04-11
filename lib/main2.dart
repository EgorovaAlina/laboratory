import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Красноярский художественный музей имени В.И. Сурикова',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  ' 660099, Красноярский край, г. Красноярск, ул. Парижской Коммуны, 20 ',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          FavoriteWidget(),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(

        'Музей основан в 1957 году. Открыт для публичного посещения 1 мая 1958 года. С 1958 г. – Красноярская'
            'краевая художественная галерея, с 1983 г. – Красноярский художественный музей им. В.И. Сурикова. '
            'Основу собрания составили произведения, переданные при организации галереи из Красноярского'
            'краеведческого музея. Многие произведения изобразительного искусства поступили в краеведческий музей из'
            'частных собраний (работы М.Ф. Квадаля, Ф.А. Васильева, К.Х. Рейхеля, Г.И. Гуркина). Значительную часть'
            'художественной коллекции составляли произведения, собранные красноярским золотопромышленником,'
            'любителем и ценителем искусств П.И. Кузнецовым, помогавшем материально В.И. Сурикову в годы учёбы в'
            'Академии художеств. В последующие годы фонды музея пополнялись произведениями через Государственный'
            'музейный фонд из Госхранилища, с 1960 по 1980-е годы – из Министерства культуры РСФСР и Министерства культуры СССР.',
        softWrap: true,
      ),
    );


    Widget textSectionTwo = Container(
      padding: const EdgeInsets.all(32),
      child: Text(

        ' В коллекции музея выделяются следующие разделы: Древнерусское искусство (иконопись, в том числе иконы'
            'сибирского письма, медное литье, церковная утварь); Русское искусство XVIII – нач. ХХ вв.; Искусство ХХ - XXI вв.;'
            'Коллекция декоративно-прикладного и народного искусства.',
        softWrap: true,
      ),
    );

    Widget textSectionThree = Container(
      padding: const EdgeInsets.all(32),
      child: Text(

        'Центральным корпусом музея, его визитной карточкой стало здание особняка, построенного в начале ХХ века по проекту известного красноярского архитектора В.А. Соколовского',
        softWrap: true,
      ),
    );


    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'Телефон'),
          _buildButtonColumn(color, Icons.near_me, 'Message'),
          _buildButtonColumn(color, Icons.share, 'Поделиться'),
        ],
      ),
    );

    Widget buttonSectionTwo = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.masks, 'Вход без маски запрещен'),
          _buildButtonColumn(color, Icons.video_call, 'Съемка разрешена'),
          _buildButtonColumn(color, Icons.no_meals , 'С едой вход запрещен'),
        ],
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Музеи',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Отели'),
          backgroundColor: Color(0xFF8D5136),
        ),
        body: ListView(
          children: [
            Image.asset(
              'lib/images/museum.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
            Image.asset(
              'lib/images/museum1.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            textSectionTwo,
            buttonSectionTwo,
            textSectionThree,
          ],
        ),
      ),
    );

  }
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Color(0xFF8D5136)),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8D5136),
            ),
          ),
        ),
      ],
    );
  }
}
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 3;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}