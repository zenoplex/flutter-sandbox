// NOTE: I'm not sure how should this be handled.
// MaterialApp.routes requires shape of Map<String, Function(BuildContext)> and I'm not sure I should import every page required here.
// I was thinking of having Map<String, Record{ String label, Function(BuildContext) fn }>
const routes = {
  'home': '/',
  'settings': '/settings',
};
