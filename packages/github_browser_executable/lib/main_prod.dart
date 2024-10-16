import 'app.dart' as runner;
import 'flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.prod;
  await runner.main();
}
