//
//  FirestoreRepository.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Firebase
import Foundation

class FirestoreRepository {
    
    private let database: Firestore
    
    init() {
        database = Firestore.firestore()
    }
    
    func getAllMeals(success: @escaping ([Meal]) -> Void, failure: @escaping (Error) -> Void) {
        database.collection("meals").getDocuments() { (snapshot, error) in
            if let error = error {
                failure(error)
            } else if let snapshot = snapshot {
                success(snapshot.documents.map { MealResponse(documentId: $0.documentID, data: $0.data()).toModel() })
            }
        }
    }
    
    func getIngredientsForDates(_ dates: [Date], success: @escaping ([Ingredient]) -> Void, failure: @escaping (Error) -> Void) {
        database.collection("meals").whereField("date", in: dates.map { $0.toStringFormatted() }).getDocuments { (snapshot, error) in
            if let error = error {
                failure(error)
            } else if let snapshot = snapshot {
                var listIngredients: [IngredientResponse] = []
                snapshot.documents.forEach { document in
                    let meal = MealResponse(data: document.data())
                    meal.ingredients.forEach { ingredient in
                        if let index = listIngredients.lastIndex(where: { $0.name == ingredient.name }) {
                            listIngredients[index].incrementQuantity(quantity: ingredient.quantity)
                        } else {
                            listIngredients.append(ingredient)
                        }
                    }
                }
                success(listIngredients.map { $0.toModel() })
            }
        }
    }
    
    func updateOrCreateMeal(_ meal: Meal, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        if let documentId = meal.documentId {
            database.collection("meals").document(documentId).updateData(meal.toResponse().data) { error in
               if let error = error {
                    failure(error)
                } else {
                    success()
                }
            }
        } else {
            database.collection("meals").addDocument(data: meal.toResponse().data) { error in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            }
        }
    }
}
