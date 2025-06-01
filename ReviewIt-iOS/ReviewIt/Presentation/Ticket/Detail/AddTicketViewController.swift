//
//  AddTicketViewController.swift
//  ReviewIt
//
//  Created by 정채은 on 6/1/25.
//

import UIKit

import PhotosUI
import SnapKit
import Then

final class AddTicketViewController: UIViewController {
    
    var seatFloor = "1"
    var seatSection = "A"
    var seatRow = "1"
    var seatNum = "1"
    
    let floorList = Array(1...5).map { "\($0)" }
    let sectionList = ["A", "B", "C", "D", "E", "F", "G", "1", "2", "3", "4", "5", "6", "7", "8"]
    let rowList = Array(0...8).map { "\($0)" }
    let numList = Array(1...999).map { "\($0)" }
    
    let datePicker = UIDatePicker()
    let seatPickerView = UIPickerView()
    
    let titleView = TitleView(title: StringLiterals.TicketDetail.title,
                              isLeftButtonHidden: false,
                              isRightButtonHidden: true)
    
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let emptyImageView = UIImageView()
    let titleTextField = TicketInputTextField(title: StringLiterals.TicketDetail.titlePlaceHolder)
    let dateTextField = TicketInputTextField()
    let castTextField = TicketInputTextField(title: StringLiterals.TicketDetail.castPlaceHolder)
    let placeTextField = TicketInputTextField(title: StringLiterals.TicketDetail.placePlaceHolder)
    
    let seatLabel = UILabel()
    let seatStackView = UIStackView()
    let seatFloorTextField = TicketInputTextField()
    let seatSectionTextField = TicketInputTextField()
    let seatRowTextField = TicketInputTextField()
    let seatNumTextField = TicketInputTextField()
    
    let platformTextField = TicketInputTextField(title: StringLiterals.TicketDetail.platformPlaceHolder)
    let priceTextField = TicketInputTextField(title: StringLiterals.TicketDetail.pricePlaceHolder)
    
    let bottomView = UIView()
    let laterButton = UIButton()
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDelegate()
        setAddTarget()
        hideKeyboardWhenTappedAround()
        setupToolBar()
        setupDatePicker()
        setupSeatPicker()
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.view.backgroundColor = .mainWhite
        
        titleLabel.do {
            $0.text = StringLiterals.TicketDetail.titleLabel
            $0.font = .fontReviewIT(.title_semibold_20)
            $0.textColor = .mainBlack
        }
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
        }
        
        posterImageView.do {
            $0.setRoundBorder(borderColor: .subGray1,
                              borderWidth: 1,
                              cornerRadius: 10)
            $0.contentMode = .scaleAspectFit
        }
        
        emptyImageView.do {
            $0.image = .empty
            $0.isUserInteractionEnabled = false
        }
        
        dateTextField.do {
            $0.setRoundBorder(borderColor: UIColor.subGray1, borderWidth: 1, cornerRadius: 10)
            $0.textColor = .mainBlack
            $0.text = DateFormatter.ticketDisplayFormatter.string(from: Date.now)
        }
        
        seatLabel.do {
            $0.text = StringLiterals.TicketDetail.seatLabel
            $0.font = .fontReviewIT(.body_semibold_15)
            $0.textColor = .mainBlack
        }
        
        seatFloorTextField.do {
            $0.text = "\(seatFloor)층"
            $0.textAlignment = .center
            $0.addPadding(left: 9, right: 9)
            $0.tag = 0
            $0.tintColor = .clear
        }
        
        seatSectionTextField.do {
            $0.text = "\(seatSection)구역"
            $0.textAlignment = .center
            $0.addPadding(left: 9, right: 9)
            $0.tag = 1
            $0.tintColor = .clear
        }
        
        seatRowTextField.do {
            $0.text = "\(seatRow)열"
            $0.textAlignment = .center
            $0.addPadding(left: 9, right: 9)
            $0.tag = 2
            $0.tintColor = .clear
        }
        
        seatNumTextField.do {
            $0.text = "\(seatNum)번"
            $0.textAlignment = .center
            $0.addPadding(left: 9, right: 9)
            $0.tag = 3
            $0.tintColor = .clear
        }
        
        seatStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.isUserInteractionEnabled = true
        }
        
        bottomView.do {
            $0.backgroundColor = .mainWhite
        }
        
        laterButton.do {
            $0.setTitle(StringLiterals.TicketDetail.laterButton, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_12)
            $0.setUnderline(forText: StringLiterals.TicketDetail.laterButton)
        }
        
        nextButton.do {
            $0.setRoundBorder(borderColor: UIColor.mainBlack,
                              borderWidth: 1,
                              cornerRadius: 10)
            $0.setTitle(StringLiterals.TicketDetail.reviewButton, for: .normal)
            $0.setTitleColor(.mainBlack, for: .normal)
            $0.titleLabel?.font = .fontReviewIT(.body_semibold_15)
            $0.setBackgroundColor(.subGray2, for: .normal)
        }
    }
    
    private func setLayout() {
        
        view.addSubviews(scrollView,
                         titleView,
                         bottomView)
        
        scrollView.addSubviews(titleLabel,
                               posterImageView,
                               titleTextField,
                               dateTextField,
                               castTextField,
                               placeTextField,
                               seatLabel,
                               seatStackView,
                               platformTextField,
                               priceTextField)
        
        seatStackView.addArrangedSubviews(seatFloorTextField,
                                          seatSectionTextField,
                                          seatRowTextField,
                                          seatNumTextField)
        
        posterImageView.addSubviews(emptyImageView)
        
        bottomView.addSubviews(laterButton,
                               nextButton)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48.adjustedHeight)
            $0.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.bottom.equalTo(bottomView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(102)
        }
        
        laterButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(5)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(24)
        }
        
        posterImageView.snp.makeConstraints {
            $0.size.equalTo(95)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 48)
            $0.height.equalTo(44)
        }
        
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
        }
        
        castTextField.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
        }
        
        placeTextField.snp.makeConstraints {
            $0.top.equalTo(castTextField.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
        }
        
        seatLabel.snp.makeConstraints {
            $0.top.equalTo(placeTextField.snp.bottom).offset(16)
            $0.leading.equalTo(titleTextField)
        }
        
        seatStackView.snp.makeConstraints {
            $0.top.equalTo(seatLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleTextField)
        }
        
        seatFloorTextField.snp.makeConstraints {
            $0.height.equalTo(43)
        }
        
        seatSectionTextField.snp.makeConstraints {
            $0.height.equalTo(43)
        }
        
        seatRowTextField.snp.makeConstraints {
            $0.height.equalTo(43)
        }
        seatNumTextField.snp.makeConstraints {
            $0.height.equalTo(43)
        }
        
        platformTextField.snp.makeConstraints {
            $0.top.equalTo(seatStackView.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
        }
        
        priceTextField.snp.makeConstraints {
            $0.top.equalTo(platformTextField.snp.bottom).offset(16)
            $0.leading.trailing.width.equalTo(titleTextField)
            $0.height.equalTo(titleTextField)
            $0.bottom.equalToSuperview().inset(21)
        }
    }
    
    private func setDelegate() {
        seatFloorTextField.delegate = self
        seatSectionTextField.delegate = self
        seatRowTextField.delegate = self
        seatNumTextField.delegate = self
    }
    
    private func setAddTarget() {
        titleView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        laterButton.addTarget(self, action: #selector(laterButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        let posterTapGesture = UITapGestureRecognizer(target: self, action: #selector(setImage))
        self.posterImageView.isUserInteractionEnabled = true
        self.posterImageView.addGestureRecognizer(posterTapGesture)
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func laterButtonTapped() {
        // 다 작성되었는지 확인하는 로직 + 저장 로직
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func nextButtonTapped() {
        // 저장 로직
        let ticketTagViewController = TicketTagViewController()
        self.navigationController?.pushViewController(ticketTagViewController, animated: true)
    }
    
    @objc private func setImage() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        dateTextField.inputView = datePicker
    }

    @objc func dateChange(_ sender: UIDatePicker) {
        dateTextField.text = DateFormatter.ticketDisplayFormatter.string(from: sender.date)
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))

        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()

        dateTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        dateTextField.text = DateFormatter.ticketDisplayFormatter.string(from: datePicker.date)
        dateTextField.resignFirstResponder()
    }
    
    @objc func setupSeatPicker() {
        seatPickerView.dataSource = self
        seatPickerView.delegate = self
        
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onPickDone))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        seatFloorTextField.inputAccessoryView = toolBar
        seatSectionTextField.inputAccessoryView = toolBar
        seatRowTextField.inputAccessoryView = toolBar
        seatNumTextField.inputAccessoryView = toolBar

        seatFloorTextField.inputView = seatPickerView
        seatSectionTextField.inputView = seatPickerView
        seatRowTextField.inputView = seatPickerView
        seatNumTextField.inputView = seatPickerView
    }
    
    @objc func onPickDone() {
        seatFloorTextField.text = "\(seatFloor)층"
        seatSectionTextField.text = "\(seatSection)구역"
        seatRowTextField.text = "\(seatRow)열"
        seatNumTextField.text = "\(seatNum)번"
        
        seatFloorTextField.resignFirstResponder()
    }
}

extension AddTicketViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case seatFloorTextField:
            seatPickerView.tag = 0
            seatPickerView.reloadAllComponents()
            if let index = floorList.firstIndex(of: seatFloor) {
                seatPickerView.selectRow(index, inComponent: 0, animated: false)
            }
        case seatSectionTextField:
            seatPickerView.tag = 1
            seatPickerView.reloadAllComponents()
            if let index = sectionList.firstIndex(of: seatSection) {
                seatPickerView.selectRow(index, inComponent: 0, animated: false)
            }
        case seatRowTextField:
            seatPickerView.tag = 2
            seatPickerView.reloadAllComponents()
            if let index = rowList.firstIndex(of: seatRow) {
                seatPickerView.selectRow(index, inComponent: 0, animated: false)
            }
        case seatNumTextField:
            seatPickerView.tag = 3
            seatPickerView.reloadAllComponents()
            if let index = numList.firstIndex(of: seatNum) {
                seatPickerView.selectRow(index, inComponent: 0, animated: false)
            }
        default:
            break
        }
    }
}

extension AddTicketViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return floorList.count
        case 1:
            return sectionList.count
        case 2:
            return rowList.count
        case 3:
            return numList.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
           case 0:
               return "\(floorList[row])층"
           case 1:
               return "\(sectionList[row])구역"
           case 2:
               return "\(rowList[row])열"
           case 3:
               return "\(numList[row])번"
           default:
               return ""
           }
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            seatFloor = floorList[row]
        case 1:
            seatSection = (sectionList[row])
        case 2:
            seatRow = (rowList[row])
        case 3:
            seatNum = (numList[row])
        default:
            break
        }
    }
}

extension AddTicketViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let result = results.first else {
            picker.dismiss(animated: true)
            return
        }

        let itemProvider = result.itemProvider
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                DispatchQueue.main.async {
                    if let image = object as? UIImage {
                        self?.posterImageView.image = image
                        self?.emptyImageView.isHidden = true
                    } else {
                        print("이미지를 불러오는 데 실패했습니다:", error?.localizedDescription ?? "Unknown error")
                    }
                }
            }
        }

        picker.dismiss(animated: true)
    }
}
