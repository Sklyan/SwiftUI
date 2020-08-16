//
//  ViewController.swift
//  OURFirstAppWithUI
//
//  Created by Евгений Склянов on 16.08.2020.
//  Copyright © 2020 Евгений Склянов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginInput: UITextField!
     //поле логин
     @IBOutlet weak var passwordInput: UITextField!
    //поле пароль
    @IBOutlet weak var scrollView: UIScrollView!
    
    @objc
    private func keyboardWasShown(notification: Notification) {
        // Получаем размер высоты клавиатуры
        guard
        let info = notification.userInfo,
        let keybSize = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {return}
        //увеличиваем размер scrollview на высоту клавиатуры
        scrollView?.contentInset.bottom = keybSize.height
    }
    
    //Восстанавливаем размер при убирании клавиатуры
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        //Работа с центром обновлений касаемо клавиатуры (включение)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Работа с центром обновлений касаемо клавиатуры (отключение)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //убираем клавиатуру при нажатии на свободное поле
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
    @IBAction func bottonTapping(_ sender: Any) {
        // Получаем текст-логин
        let login = loginInput.text!
        // Получаем текст-пароль
        let password = passwordInput.text!
        
        // Проверяем, верны ли они
        if login == "user" && password == "123" {
            print("Спасибо что зашли!")
        } else {
            print("Неправильная пара логин/пароль")
        }
    }
    
}
