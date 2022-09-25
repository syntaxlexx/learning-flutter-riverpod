class Calculator {
  final bool shouldAppend;
  final String equation;
  final String result;

  const Calculator({
    this.shouldAppend = true,
    this.equation = '0',
    this.result = '0',
  });

  Calculator copy({
    bool? shouldAppend,
    String? equation,
    String? result,
  }) =>
      Calculator(
        shouldAppend: shouldAppend ?? this.shouldAppend,
        equation: equation ?? this.equation,
        result: result ?? this.result,
      );
}
