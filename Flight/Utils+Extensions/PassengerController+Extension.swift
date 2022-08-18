//
//  PassengerController+Extension.swift
//  Flight
//
//  Created by ARCHER on 19/08/2022.
//

import Foundation
import UIKit

extension PassengerController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPassengers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PassengerTableCell.reuseIdentifier, for: indexPath) as! PassengerTableCell
            cell.configureCell(viewModel: viewModel,indexPath:indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
