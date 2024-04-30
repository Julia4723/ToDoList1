//
//  ViewController.swift
//  ToDoList
//
//  Created by user on 30.04.2024.
//

import UIKit




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
        showAlert(withTitle: "Save task", andMassage: "What do you want to do?")
        
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
    
    
    private func showAlert(withTitle title: String, andMassage massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save task", style: .default) { [unowned self] _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            save(task)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "New task"
        }
        present(alert, animated: true)
        
    }
    
    
    private func save(_ taskName: String) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        let task = NewTask(context: appDelegate.persistentContainer.viewContext)//экземпляр модели
        task.title = taskName//задаем значение для задачи
        taskList.append(task)//добавляем задачу в массив
        
        //отображение добавления строки
        let indexPath = IndexPath(row: taskList.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        
        appDelegate.saveContext()
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

