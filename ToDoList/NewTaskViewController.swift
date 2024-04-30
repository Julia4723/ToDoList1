//
//  NewTaskViewController.swift
//  ToDoList
//
//  Created by user on 30.04.2024.
//

import UIKit




final class NewTaskViewController: UIViewController {
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New task"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    
    //кнопка сохранения
    private lazy var cancelButton: UIButton = {
        //Устанавливаем атрибуты для кнопки
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 17)
        
        
        // Создание кнопки
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.baseBackgroundColor = UIColor.redMilk
        buttonConfig.attributedTitle = AttributedString("Cancel", attributes: attributes)
        
        let button = UIButton(configuration: buttonConfig, primaryAction: UIAction { [unowned self] _ in
            dismiss(animated: true)
        })
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    
    
    
    //кнопка сохранения
    private lazy var saveButton: UIButton = {
        //Устанавливаем атрибуты для кнопки
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 17)
        
        
        // Создание кнопки
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.baseBackgroundColor = UIColor.blueMilk
        buttonConfig.attributedTitle = AttributedString("Save task", attributes: attributes)
        
        let button = UIButton(configuration: buttonConfig, primaryAction: UIAction { [unowned self] _ in
            save()
        })
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    
    
    //Создаем делегата
    weak var delegate: NewTaskViewControllerDelegate?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(taskTextField, saveButton, cancelButton)//добавляем вью
        
        setConstraints()
    }
    
    
    
    //метод добавляет саб вью
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
        
    }
    
    
    //метод устанавливает констрейнсы
    private func setConstraints() {
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            
        ])
    }
    
    
    

    
    
    private func save() {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }//создаем экземпляр appDelegate
        let task = NewTask(context: appDelegate.persistentContainer.viewContext)//создаем экземпляр модели
        task.title = taskTextField.text//обновили данные
        appDelegate.saveContext()//сохраняем данные
        delegate?.reloadData() //вызываем метод у делегата
        dismiss(animated: true)
    }
    
}

#Preview {
    NewTaskViewController()
}
