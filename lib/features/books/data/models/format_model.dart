import 'package:guttenberg_book_apps/features/books/domain/entities/formats.dart';

class FormatModel extends Formats {
  const FormatModel({
    super.textHtml,
    super.applicationEpubZip,
    super.applicationOctetStream,
    super.applicationRdfXml,
    super.applicationXMobipocketEbook,
    super.imageJpeg,
    super.textPlainCharsetUsAscii,
  });

  factory FormatModel.fromJson(Map<String, dynamic> json) => FormatModel(
      textHtml: json['text/html'],
      applicationEpubZip: json['application/epub+zip'],
      applicationXMobipocketEbook: json['application/x-mobipocket-ebook'],
      applicationRdfXml: json['application/rdf+xml'],
      imageJpeg: json['image/jpeg'],
      textPlainCharsetUsAscii: json['text/plain; charset=us-ascii']);

  Map<String, dynamic> toJson() => {
        "text/html": textHtml,
        "application/epub+zip": applicationEpubZip,
        "application/x-mobipocket-ebook": applicationXMobipocketEbook,
        "application/rdf+xml": applicationRdfXml,
        "image/jpeg": imageJpeg,
        "application/octet-stream": applicationOctetStream,
        "text/plain; charset=us-ascii": textPlainCharsetUsAscii,
      };
}
