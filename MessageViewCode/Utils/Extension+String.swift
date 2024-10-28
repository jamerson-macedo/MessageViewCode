//
//  UiView.swift
//  MessageViewCode
//
//  Created by Jamerson Macedo on 28/10/24.
//

import UIKit

extension String {
    
    // Função que calcula o tamanho de um texto com uma fonte específica.
    func size(font: UIFont) -> CGSize {
        // Converte a String para NSString e calcula o tamanho do texto usando atributos específicos, neste caso, a fonte fornecida.
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    // Função que calcula a altura do texto quando a largura máxima é limitada, levando em consideração a fonte.
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        // Define um retângulo de restrição com uma largura fixa e altura máxima infinita (ou seja, sem limite de altura).
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        // Calcula o retângulo delimitador que o texto ocuparia, levando em consideração as opções de quebra de linha e a fonte.
        let boundingBox = self.boundingRect(
            with: constraintRect,                                // O retângulo de restrição.
            options: [.usesLineFragmentOrigin, .usesFontLeading], // Opções que dizem como o texto deve ser ajustado no retângulo.
            attributes: [NSAttributedString.Key.font: font],     // Atributos de formatação, neste caso, apenas a fonte.
            context: nil                                         // Contexto opcional para ajustes gráficos, aqui não é necessário.
        )
        
        // Retorna a altura do retângulo delimitador calculado.
        return boundingBox.height
    }
    
}
