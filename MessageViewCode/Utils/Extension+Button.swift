//
//  UiView.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 28/10/24.
//

import UIKit

extension UIButton {
    
    // Função que anima um UIButton quando ele é tocado.
    func touchAnimation(s: UIButton) {
        
        // Animação inicial - reduz o tamanho do botão para 80% da escala original.
        UIView.animate(
            withDuration: 0.1,                 // Duração da animação: 0.1 segundos.
            delay: 0,                          // Sem atraso antes de iniciar a animação.
            usingSpringWithDamping: 0.5,       // Damping controla a resistência da mola (0.5 é um meio termo, permitindo um leve efeito de bounce).
            initialSpringVelocity: 0,          // Velocidade inicial da mola (0 significa que começa devagar).
            options: .curveEaseInOut,          // A animação começa e termina suavemente.
            animations: {
                // Reduz o botão para 80% do tamanho original.
                s.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
            },
            completion: { finish in
                // Animação de retorno - volta o botão para o tamanho original.
                UIButton.animate(
                    withDuration: 0.5,             // Duração da animação de retorno: 0.5 segundos.
                    delay: 0,                      // Sem atraso antes de iniciar a animação de retorno.
                    usingSpringWithDamping: 0.3,   // Damping mais leve (0.3) para um efeito de bounce mais perceptível.
                    initialSpringVelocity: 0,      // Velocidade inicial da mola permanece 0.
                    options: .curveEaseInOut,      // A animação começa e termina suavemente.
                    animations: {
                        // Retorna o botão ao estado original.
                        s.transform = .identity    // `.identity` significa que a escala volta ao normal (1.0, 1.0).
                    }
                )
            }
        )
    }
    
}
