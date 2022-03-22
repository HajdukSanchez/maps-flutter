import 'package:flutter/material.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _AccessButton(),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15, left: 30, right: 30),
          child: const Text(
            "It is necessary to enable GPS access in order to use this app.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ),
        MaterialButton(
          onPressed: () {},
          child: const Text(
            "Request access",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          elevation: 0,
          splashColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Enable GPS to continue.',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
    );
  }
}
