import 'abstract.dart';
import 'utils.dart' as utils;

class ICalendar extends AbstractSerializer {
  List<ICalendarElement> _elements = <ICalendarElement>[];
  String company;
  String product;
  String lang;
  Duration refreshInterval;

  ICalendar({
    this.company = 'dartclub',
    this.product = 'ical_serializer',
    this.lang = 'EN',
    this.refreshInterval = null,
  });

  addAll(List<ICalendarElement> elements) => _elements.addAll(elements);
  addElement(ICalendarElement element) => _elements.add(element);

  @override
  String serialize() {
    var out = StringBuffer()
      ..writeln('BEGIN:VCALENDAR')
      ..writeln('VERSION:2.0')
      ..writeln('PRODID://${company}//${product}//${lang}');

    if (refreshInterval != null) {
      out.writeln('REFRESH-INTERVAL;VALUE=DURATION:${utils.formatDuration(refreshInterval)}');
    }

    for (ICalendarElement element in _elements) {
      out.write(element.serialize());
    }

    out.writeln('END:VCALENDAR');
    return out.toString();
  }
}
