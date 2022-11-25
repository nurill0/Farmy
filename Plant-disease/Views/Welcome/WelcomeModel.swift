//
//  WelcomeModel.swift
//  Plant-disease
//
//  Created by Nurillo Domlajonov on 26/10/22.
//

import Foundation

struct Welcome{
    let title: String
    let description: String
    let lottieName: String
}


struct WelcomeData{
    
    let data: [Welcome] = [
        Welcome(title: "O`simligingizni kasalligini aniqlayolmayapsizmi?", description: "Bizga o'simlik rasmini yuklang,biz esa sizga undagi kasallikni aniqlashga yordam beramiz !", lottieName: "welcome2"),
        Welcome(title: "Sotish va sotib olishda shaffoflik qidiryapsizmi?", description: "Biz sizga mevalardan tortib poliz ekinlarigacha oson sotish va sotib olishni taklif qilamiz !", lottieName: "welcome3"),
        Welcome(title: "Ish topish yoki ishchi qidirishda muammo bormi?", description: "Biz orqali o`zingizga oson ish va ishchi toping.Ishchilar va ish beruvchilar uchun eng afzal yechim - Farmy", lottieName: "welcome3"),
    ]
    
    
    func getSize()->Int{
        return data.count
    }
    
    
    func getItem(index: Int)->Welcome{
        return data[index]
    }
    
}
