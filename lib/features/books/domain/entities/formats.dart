import 'package:equatable/equatable.dart';

class Formats extends Equatable {
  final String? textHtml;
  final String? applicationEpubZip;
  final String? applicationXMobipocketEbook;
  final String? applicationRdfXml;
  final String? imageJpeg;
  final String? applicationOctetStream;
  final String? textPlainCharsetUsAscii;

  const Formats({
    this.textHtml,
    this.applicationEpubZip,
    this.applicationXMobipocketEbook,
    this.applicationRdfXml,
    this.imageJpeg,
    this.applicationOctetStream,
    this.textPlainCharsetUsAscii,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        textHtml,
        applicationEpubZip,
        applicationEpubZip,
        applicationXMobipocketEbook,
        applicationRdfXml,
        imageJpeg,
        applicationOctetStream,
        textPlainCharsetUsAscii,
      ];
}
