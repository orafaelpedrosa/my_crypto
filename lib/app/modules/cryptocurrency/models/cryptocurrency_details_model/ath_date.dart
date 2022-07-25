import 'dart:convert';

class AthDate {
  String? aed;
  String? ars;
  String? aud;
  String? bch;
  String? bdt;
  String? bhd;
  String? bmd;
  String? bnb;
  String? brl;
  String? btc;
  String? cad;
  String? chf;
  String? clp;
  String? cny;
  String? czk;
  String? dkk;
  String? dot;
  String? eos;
  String? eth;
  String? eur;
  String? gbp;
  String? hkd;
  String? huf;
  String? idr;
  String? ils;
  String? inr;
  String? jpy;
  String? krw;
  String? kwd;
  String? lkr;
  String? ltc;
  String? mmk;
  String? mxn;
  String? myr;
  String? ngn;
  String? nok;
  String? nzd;
  String? php;
  String? pkr;
  String? pln;
  String? rub;
  String? sar;
  String? sek;
  String? sgd;
  String? thb;
  String? try_;
  String? twd;
  String? uah;
  String? usd;
  String? vef;
  String? vnd;
  String? xag;
  String? xau;
  String? xdr;
  String? xlm;
  String? xrp;
  String? yfi;
  String? zar;
  String? bits;
  String? link;
  String? sats;

  AthDate({
    this.aed,
    this.ars,
    this.aud,
    this.bch,
    this.bdt,
    this.bhd,
    this.bmd,
    this.bnb,
    this.brl,
    this.btc,
    this.cad,
    this.chf,
    this.clp,
    this.cny,
    this.czk,
    this.dkk,
    this.dot,
    this.eos,
    this.eth,
    this.eur,
    this.gbp,
    this.hkd,
    this.huf,
    this.idr,
    this.ils,
    this.inr,
    this.jpy,
    this.krw,
    this.kwd,
    this.lkr,
    this.ltc,
    this.mmk,
    this.mxn,
    this.myr,
    this.ngn,
    this.nok,
    this.nzd,
    this.php,
    this.pkr,
    this.pln,
    this.rub,
    this.sar,
    this.sek,
    this.sgd,
    this.thb,
    this.try_,
    this.twd,
    this.uah,
    this.usd,
    this.vef,
    this.vnd,
    this.xag,
    this.xau,
    this.xdr,
    this.xlm,
    this.xrp,
    this.yfi,
    this.zar,
    this.bits,
    this.link,
    this.sats,
  });

  Map<String, dynamic> toMap() {
    return {
      'aed': aed,
      'ars': ars,
      'aud': aud,
      'bch': bch,
      'bdt': bdt,
      'bhd': bhd,
      'bmd': bmd,
      'bnb': bnb,
      'brl': brl,
      'btc': btc,
      'cad': cad,
      'chf': chf,
      'clp': clp,
      'cny': cny,
      'czk': czk,
      'dkk': dkk,
      'dot': dot,
      'eos': eos,
      'eth': eth,
      'eur': eur,
      'gbp': gbp,
      'hkd': hkd,
      'huf': huf,
      'idr': idr,
      'ils': ils,
      'inr': inr,
      'jpy': jpy,
      'krw': krw,
      'kwd': kwd,
      'lkr': lkr,
      'ltc': ltc,
      'mmk': mmk,
      'mxn': mxn,
      'myr': myr,
      'ngn': ngn,
      'nok': nok,
      'nzd': nzd,
      'php': php,
      'pkr': pkr,
      'pln': pln,
      'rub': rub,
      'sar': sar,
      'sek': sek,
      'sgd': sgd,
      'thb': thb,
      'try_': try_,
      'twd': twd,
      'uah': uah,
      'usd': usd,
      'vef': vef,
      'vnd': vnd,
      'xag': xag,
      'xau': xau,
      'xdr': xdr,
      'xlm': xlm,
      'xrp': xrp,
      'yfi': yfi,
      'zar': zar,
      'bits': bits,
      'link': link,
      'sats': sats,
    };
  }

  factory AthDate.fromMap(Map<String, dynamic> map) {
    return AthDate(
      aed: map['aed'],
      ars: map['ars'],
      aud: map['aud'],
      bch: map['bch'],
      bdt: map['bdt'],
      bhd: map['bhd'],
      bmd: map['bmd'],
      bnb: map['bnb'],
      brl: map['brl'],
      btc: map['btc'],
      cad: map['cad'],
      chf: map['chf'],
      clp: map['clp'],
      cny: map['cny'],
      czk: map['czk'],
      dkk: map['dkk'],
      dot: map['dot'],
      eos: map['eos'],
      eth: map['eth'],
      eur: map['eur'],
      gbp: map['gbp'],
      hkd: map['hkd'],
      huf: map['huf'],
      idr: map['idr'],
      ils: map['ils'],
      inr: map['inr'],
      jpy: map['jpy'],
      krw: map['krw'],
      kwd: map['kwd'],
      lkr: map['lkr'],
      ltc: map['ltc'],
      mmk: map['mmk'],
      mxn: map['mxn'],
      myr: map['myr'],
      ngn: map['ngn'],
      nok: map['nok'],
      nzd: map['nzd'],
      php: map['php'],
      pkr: map['pkr'],
      pln: map['pln'],
      rub: map['rub'],
      sar: map['sar'],
      sek: map['sek'],
      sgd: map['sgd'],
      thb: map['thb'],
      try_: map['try_'],
      twd: map['twd'],
      uah: map['uah'],
      usd: map['usd'],
      vef: map['vef'],
      vnd: map['vnd'],
      xag: map['xag'],
      xau: map['xau'],
      xdr: map['xdr'],
      xlm: map['xlm'],
      xrp: map['xrp'],
      yfi: map['yfi'],
      zar: map['zar'],
      bits: map['bits'],
      link: map['link'],
      sats: map['sats'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AthDate.fromJson(String source) =>
      AthDate.fromMap(json.decode(source));
}
