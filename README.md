# Side Track

Well this is meant to be a habit tracker but with a twist.

#### Habit Tracking

Tracking daily habits and using a heatmap to display the days where the habits were completed.
Its following a similar style to how Github's commit history works.
Inspiration comes from [Mitch Koko](https://www.youtube.com/watch?v=2VKpq4h3Sdw&pp=ygUYbWl0Y2gga29rbyBoYWJpdCB0cmFja2Vy)

#### Note Writeups

There is a place for notes, just to add for the day or really just to add randomly.
I preferred using AppFlowyEditor its still fairly new but its stable enough to use in production.
This is because I like writing my notes in Markdown so very useful.

#### Ingredients Used

- [AppFlowy Editor](https://pub.dev/packages/appflowy_editor) highly customizable rich text editor.
- [Hive Database](https://pub.dev/packages/hive) uses a key/value pair time of storage. Aims to have faster CRUD operation times. Of course there is a limit for large databases.
- [Riverpod](https://pub.dev/packages/riverpod) an alternative to the default Provider which has alot of issues that need fixing, its also simple to use really.
- [Flutter heatmap](https://pub.dev/packages/flutter_heatmap_calendar) displays a nice heatmap for the habit tracker.
- [Get](https://pub.dev/packages/get) package allows one to navigate to different screens without using Navigator.of(context).push(ScreenName()).

