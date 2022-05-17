#if !os(macOS)
import UIKit

open class EnumerationPickerView<EnumerationCase: Equatable & CaseIterable>
: UIPickerView, UIPickerViewDataSource & UIPickerViewDelegate
where EnumerationCase.AllCases.Index == Int {
  public typealias HandleSelection = (EnumerationCase) -> Void

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    dataSource = self
    delegate = self
  }

  private var handleSelection: HandleSelection?

//MARK: UIPickerViewDataSource
  public func numberOfComponents(in _: UIPickerView) -> Int { 1 }

  public func pickerView(
    _: UIPickerView,
    numberOfRowsInComponent _: Int
  ) -> Int {
    EnumerationCase.allCases.count
  }

//MARK: UIPickerViewDelegate
  public func pickerView(
    _: UIPickerView,
    didSelectRow rowIndex: Int,
    inComponent _: Int
  ) {
    handleSelection?(EnumerationCase.allCases[rowIndex])
  }

  public func pickerView(
    _: UIPickerView,
    titleForRow rowIndex: Int,
    forComponent _: Int
  ) -> String? {
    "\(EnumerationCase.allCases[rowIndex])"
  }
}

// MARK: - public
public extension EnumerationPickerView {
  var selection: EnumerationCase? {
    let index = selectedRow(inComponent: 0)

    guard EnumerationCase.allCases.indices.contains(index)
    else { return nil }

    return EnumerationCase.allCases[index]
  }

  func inject(handleSelection: @escaping HandleSelection) {
    self.handleSelection = handleSelection
  }

  func setCase(_ case: EnumerationCase) {
    selectRow(
      EnumerationCase.allCases.firstIndex(of: `case`)!,
      inComponent: 0, animated: true
    )
  }
}
#endif
