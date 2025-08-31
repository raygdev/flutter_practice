// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:flutter_practice/src/app.dart';
import 'package:network_image_mock/network_image_mock.dart';

@GenerateMocks([Client])
import 'widget_test.mocks.dart';




void main() {
  late MockClient mockHttpclient;

  setUp(() {
    mockHttpclient = MockClient();
  });

  testWidgets('Images load when button is pressed', (WidgetTester tester) async {
    when(mockHttpclient.get(Uri.parse('https://jsonplaceholder.typicode.com/photos/1')))
     .thenAnswer((_) async {
      return Response(
        '{"id":1,"title":"accusamus beatae ad facilis cum similique qui sunt","url":"https://via.placeholder.com/600/92c952"}',
        200
      );
     });
    // wrap app for failing tests with image network
    mockNetworkImagesFor(() async {
      // initialize app
      await tester.pumpWidget(App(client: mockHttpclient));

      // no text should be found until button is pressed
      expect(find.text('accusamus beatae ad facilis cum similique qui sunt'), findsNothing);

      //Tap + button to load image/title
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // image title should be present
      expect(find.text('accusamus beatae ad facilis cum similique qui sunt'), findsOneWidget);
    });
  });
}
