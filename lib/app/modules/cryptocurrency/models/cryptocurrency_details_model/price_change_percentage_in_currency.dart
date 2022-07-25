import 'dart:convert';

class PriceChangePercentageInCurrency {
  double? aed;
  double? ars;
  double? aud;
  double? bch;
  double? bdt;
  double? bhd;
  double? bmd;
  double? bnb;
  double? brl;
  double? btc;
  double? cad;
  double? chf;
  double? clp;
  double? cny;
  double? czk;
  double? dkk;
  double? dot;
  double? eos;
  double? eth;
  double? eur;
  double? gbp;
  double? hkd;
  double? huf;
  double? idr;
  double? ils;
  double? inr;
  double? jpy;
  double? krw;
  double? kwd;
  double? lkr;
  double? ltc;
  double? mmk;
  double? mxn;
  double? myr;
  double? ngn;
  double? nok;
  double? nzd;
  double? php;
  double? pkr;
  double? pln;
  double? rub;
  double? sar;
  double? sek;
  double? sgd;
  double? thb;
  double? try_;
  double? twd;
  double? uah;
  double? usd;
  double? vef;
  double? vnd;
  double? xag;
  double? xau;
  double? xdr;
  double? xlm;
  double? xrp;
  double? yfi;
  double? zar;
  double? bits;
  double? link;
  double? sats;

  PriceChangePercentageInCurrency({
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

  factory PriceChangePercentageInCurrency.fromMap(Map<String, dynamic> data) {
    return PriceChangePercentageInCurrency(
      aed: (data['aed'] as num?)?.toDouble(),
      ars: (data['ars'] as num?)?.toDouble(),
      aud: (data['aud'] as num?)?.toDouble(),
      bch: (data['bch'] as num?)?.toDouble(),
      bdt: (data['bdt'] as num?)?.toDouble(),
      bhd: (data['bhd'] as num?)?.toDouble(),
      bmd: (data['bmd'] as num?)?.toDouble(),
      bnb: (data['bnb'] as num?)?.toDouble(),
      brl: (data['brl'] as num?)?.toDouble(),
      btc: (data['btc'] as num?)?.toDouble(),
      cad: (data['cad'] as num?)?.toDouble(),
      chf: (data['chf'] as num?)?.toDouble(),
      clp: (data['clp'] as num?)?.toDouble(),
      cny: (data['cny'] as num?)?.toDouble(),
      czk: (data['czk'] as num?)?.toDouble(),
      dkk: (data['dkk'] as num?)?.toDouble(),
      dot: (data['dot'] as num?)?.toDouble(),
      eos: (data['eos'] as num?)?.toDouble(),
      eth: (data['eth'] as num?)?.toDouble(),
      eur: (data['eur'] as num?)?.toDouble(),
      gbp: (data['gbp'] as num?)?.toDouble(),
      hkd: (data['hkd'] as num?)?.toDouble(),
      huf: (data['huf'] as num?)?.toDouble(),
      idr: (data['idr'] as num?)?.toDouble(),
      ils: (data['ils'] as num?)?.toDouble(),
      inr: (data['inr'] as num?)?.toDouble(),
      jpy: (data['jpy'] as num?)?.toDouble(),
      krw: (data['krw'] as num?)?.toDouble(),
      kwd: (data['kwd'] as num?)?.toDouble(),
      lkr: (data['lkr'] as num?)?.toDouble(),
      ltc: (data['ltc'] as num?)?.toDouble(),
      mmk: (data['mmk'] as num?)?.toDouble(),
      mxn: (data['mxn'] as num?)?.toDouble(),
      myr: (data['myr'] as num?)?.toDouble(),
      ngn: (data['ngn'] as num?)?.toDouble(),
      nok: (data['nok'] as num?)?.toDouble(),
      nzd: (data['nzd'] as num?)?.toDouble(),
      php: (data['php'] as num?)?.toDouble(),
      pkr: (data['pkr'] as num?)?.toDouble(),
      pln: (data['pln'] as num?)?.toDouble(),
      rub: (data['rub'] as num?)?.toDouble(),
      sar: (data['sar'] as num?)?.toDouble(),
      sek: (data['sek'] as num?)?.toDouble(),
      sgd: (data['sgd'] as num?)?.toDouble(),
      thb: (data['thb'] as num?)?.toDouble(),
      try_: (data['try'] as num?)?.toDouble(),
      twd: (data['twd'] as num?)?.toDouble(),
      uah: (data['uah'] as num?)?.toDouble(),
      usd: (data['usd'] as num?)?.toDouble(),
      vef: (data['vef'] as num?)?.toDouble(),
      vnd: (data['vnd'] as num?)?.toDouble(),
      xag: (data['xag'] as num?)?.toDouble(),
      xau: (data['xau'] as num?)?.toDouble(),
      xdr: (data['xdr'] as num?)?.toDouble(),
      xlm: (data['xlm'] as num?)?.toDouble(),
      xrp: (data['xrp'] as num?)?.toDouble(),
      yfi: (data['yfi'] as num?)?.toDouble(),
      zar: (data['zar'] as num?)?.toDouble(),
      bits: (data['bits'] as num?)?.toDouble(),
      link: (data['link'] as num?)?.toDouble(),
      sats: (data['sats'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
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
        'try': try_,
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

  factory PriceChangePercentageInCurrency.fromJson(String data) {
    return PriceChangePercentageInCurrency.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
