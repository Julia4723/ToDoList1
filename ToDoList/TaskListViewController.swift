//
//  ViewController.swift
//  ToDoList
//
//  Created by user on 30.04.2024.
//

import UIKit

protocol NewTaskViewControllerDelegate: AnyObject {
    func reloadData()
}

final class TaskListViewController: UITableViewController {

   
    private var taskList: [NewTask] = []
    private let cellID = "task"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = .white//Задаем цвет фона вью
        setupNavigationBar()
        fetchData()
    }
    
    //Метод для кнопки в навигейшн баре
    @objc private func addNewTask() {
        
        //Делаем переход на другой экран
        let newTaskVC = NewTaskViewController()//Создаем экземпляр класса
        newTaskVC.delegate = self//Инициализация делегата при переходе
        present(newTaskVC, animated: true)//отображение экрана
        
    }
    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)//создаем обьект ячейки
        let task = taskList[indexPath.row]//извлекаем из массива обьект по индексу текущей строки
        var content = cell.defaultContentConfiguration()//создаем контент
        content.text = task.title//настройка контента
        cell.contentConfiguration = content//передаем значение
        return cell
    }
    
    //метод восстанавливает данные из базы
    private func fetchData() {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        let fetchRequest = NewTask.fetchRequest()
        
        do {
            taskList = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        } catch{
            print(error.localizedDescription)
        }
    }


}

//MARK: - NewTaskViewControllerDelegate
extension TaskListViewController: NewTaskViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}



// MARK: - SetupUI

private extension TaskListViewController {
    func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Navigation bar appearance
        let navBarAppearance = UINavigationBarAppearance()//Конфигурация для навигейшн бара
        navBarAppearance.backgroundColor = UIColor.blueMilk
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]//Задаем цвет для заголовка
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]//Задаем цвет для заголовка(большой)
        
        //Добавляем кнопку в навбар
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white//задаем цвет для кнопки в навбаре
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance//Настройка размера навбара
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance//Настройка размера навбара
        
        
        
        
        
        
    }
}

